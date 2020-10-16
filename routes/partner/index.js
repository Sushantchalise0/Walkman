const express = require("express");
const partnerRouter = express.Router();
const PartnerUser = require("../../models/Partner/PartnerUser");
const { partnerAuth } = require("../../helpers/partnerAuthen");
const bcrypt = require("bcryptjs");
const partnerpassport = require("passport");
const PartnerStrategy = require("passport-local").Strategy;
const partnersession = require("express-session");
const partnerflash = require("connect-flash");

// partnerRouter.all('/*', (req, res, next) => {

//     req.app.locals.layout = 'partner';
//     next();
// });
// partnerRouter.use(partnersession({

//     secret: 'sandeepCodingCMS',
//     resave: true,
//     saveUninitialized: true
// }));

// partnerRouter.use(partnerflash());

// partnerRouter.use(partnerpassport.initialize());
// partnerRouter.use(partnerpassport.session());

partnerRouter.get("/", (req, res) => {
	res.render("partner/login", {});
});

//
partnerRouter.get("/login", (req, res) => {
	res.render("partner/login");
});

//APP LOGIN
// partnerpassport.use('/partnerSession',new PartnerStrategy({usernameField: 'email'}, (email, password, done) => {

//     PartnerUser.findOne({email: email}).then(user => {

//         if(!user) return done(null, false, {message: 'No user found'});

//         bcrypt.compare(password, user.password, (err, matched) => {

//             if(err) return err;

//             if(matched){
//                 console.log("matched password from partner");
//                 return done(null, user);
//             } else {
//                 console.log("matched wrong from partner");
//                 return done(null, false, {message: 'Incorrect password'});
//             }
//         });
//     });
// }));

// partnerpassport.serializeUser(function(user, done) {
//     done(null, user.id);
//     console.log("i am in serializer");
// });

// partnerpassport.deserializeUser(function(id, done) {
//     PartnerUser.findById(id, function(err, user) {
//         done(err, user);
//         console.log("i am in deserializer");
//     });
// });
// partnerRouter.post('/login', (req, res, next) => {

//     partnerpassport.authenticate('local', {

//      successRedirect: '/partner/addcoin/create',
//      failureRedirect: '/partner/login',
//      failureFlash: true

//      })(req, res, next);
//  });
partnerRouter.post("/login", function(req, res, next) {
	// console.log("partner login post area");

	PartnerUser.findOne({ email: req.body.email }).then(user => {
		if (!user) res.redirect("/partner/login");

		bcrypt.compare(req.body.password, user.password, (err, matched) => {
			if (err) return err;

			if (matched) {
				// console.log("matched password from partner");
				// return done(null, user);
				// req.username.partnerData = user.password;
				req.session.partnerSuccess = "sandeepPartnerSession";
				res.redirect("/partner/addcoin");
				// req.isAuthenticated()==true;
				//    partnerpassport.authenticate(req.isAuthenticated==true, res, next);
				// var authenticated ="sandeepTrue";
				// console.log(authenticated);
			} else {
				// console.log("matched wrong from partner");
				// return done(null, false, {message: 'Incorrect password'});
				res.redirect("/partner/login");
			}
		});
	});
});
//    partnerpassport.authenticate('local', {
//     successRedirect: '/partner/addcoin/create',
//     failureRedirect: '/partner/login',
//     failureFlash: true
//     })(req, res, next);
// });

// partnerRouter.post('/dataa', (req, res, next) => {
//     partnerpassport.authenticate('local', (err, user, info) => {
//       if(info) {return res.send(info.message)}
//       if (err) { return next(err); }
//       if (!user) { return res.redirect('/dataa'); }
//       req.login(user, (err) => {
//         if (err) { return next(err); }
//         return res.redirect('/authrequired');
//       })
//     })(req, res, next);
//   })

//   partnerRouter.get('/authrequired', (req, res) => {
//     if(req.isAuthenticated()) {
//       res.send('you hit the authentication endpoint\n')
//     } else {
//       res.redirect('/')
//     }
//   })

//LOGOUT
partnerRouter.get("/logout", (req, res) => {
	req.logout();
	req.session.destroy();
	res.render("partner/login");
});

partnerRouter.get("/dandoomaharjan", (req, res) => {
	res.render("partner/register");
});

partnerRouter.post("/dandoomaharjan", (req, res) => {
	let errors = [];
	if (!req.body.firstName) {
		errors.push({ message: "please add a firstname" });
	}

	if (!req.body.lastName) {
		errors.push({ message: "please add a lastname" });
	}

	if (!req.body.email) {
		errors.push({ message: "please add a email" });
	}

	if (!req.body.password) {
		errors.push({ message: "please add a password" });
	}

	if (req.body.password !== req.body.passwordConfirm) {
		errors.push({ message: "password field dont match" });
	}

	if (errors.length > 0) {
		res.render("partner/register", {
			errors: errors,
			firstName: req.body.firstName,
			lastName: req.body.lastName,
			email: req.body.email
		});
	} else {
		PartnerUser.findOne({ email: req.body.email }).then(user => {
			if (!user) {
				const newUser = new PartnerUser({
					firstName: req.body.firstName,
					lastName: req.body.lastName,
					email: req.body.email,
					password: req.body.password
				});

				bcrypt.genSalt(10, (err, salt) => {
					bcrypt.hash(newUser.password, salt, (err, hash) => {
						newUser.password = hash;
						newUser.save().then(savedUser => {
							req.flash(
								"success_message",
								`PartnerUser ${newUser.firstName} was successfully created`
							);
							res.redirect("/partner/login");
						});
					});
				});
			} else {
				req.flash("error_message", `User already exists`);
				res.redirect("/dandoomaharjan");
			}
		});
	}
});

module.exports = partnerRouter;
