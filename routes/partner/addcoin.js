// const express = require("express");
// const partnerRouter = express.Router();
// const { partnerAuth } = require("../../helpers/partnerAuthen");
// const AddCoin = require("../../models/partner/Addcoin");
// const Unitss = require("../../models/partner/Units");
// const Detail = require("../../models/Detail");

// partnerRouter.all("/*", partnerAuth, (req, res, next) => {
// 	// console.log( req.session.partnerSuccess);
// 	req.app.locals.layout = "partner";
// 	next();
// });
// //READ addcoin
// partnerRouter.get("/", (req, res) => {
// 	var mysort = { addedDate: -1 };
// 	AddCoin.find({})
// 		.sort(mysort)
// 		.populate("detail")
// 		.then(addcoin => {
// 			res.render("partner/addcoin", { addcoin: addcoin });
// 		});
// });

// //CREATE addcoin
// partnerRouter.get("/create", (req, res) => {
// 	AddCoin.find({}).then(addcoin => {
// 		Detail.find({}).then(details => {
// 			Unitss.find({}).then(units => {
// 				res.render("partner/addcoin/create", {
// 					addcoin: addcoin,
// 					details: details,
// 					units: units
// 				});
// 			});
// 		});
// 	});

// 	// AddCoin.find({}).then(addcoin => {
// 	//     res.render('partner/addcoin/create', {addcoin: addcoin});
// 	// });
// });

// partnerRouter.post("/create", (req, res) => {
// 	var det = req.body.detail;
// 	var mail = req.body.mailid;
// 	// console.log(met, unt);
// 	const newAddCoin = new AddCoin({
// 		detail: det,
// 		mailid: mail,
// 		unit: req.body.unit,
// 		metric: req.body.metric,
// 		coins: req.body.coins
// 	});
// 	// console.log(newAddCoin);
// 	newAddCoin
// 		.save()
// 		.then(savedAddCoin => {
// 			req.flash("success_message", `Post was successfully created`);

// 			res.redirect("/partner/addcoin");
// 		})
// 		.catch(error => {
// 			console.log("couldnot save post");
// 		});
// });

// //DELETE BLOG
// partnerRouter.delete("/:id", (req, res) => {
// 	AddCoin.findOne({ _id: req.params.id }).then(addcoin => {
// 		addcoin.remove().then(updatedaddcoin => {
// 			req.flash("success_message", `successfully deleted`);
// 			res.redirect("/partner/addcoin");
// 		});
// 	});
// });

// //GO TO EDIT
// partnerRouter.get("/edit/:id", (req, res) => {
// 	AddCoin.findOne({ _id: req.params.id }).then(addcoin => {
// 		res.render("partner/addcoin/edit", { addcoin: addcoin });
// 	});
// });

// //UPDATE BLOG
// partnerRouter.put("/edit/:id", (req, res) => {
// 	AddCoin.findOne({ _id: req.params.id }).then(addcoinss => {
// 		// blog.user = req.user.id;
// 		addcoinss.title = req.body.title;
// 		addcoinss.description = req.body.description;
// 		addcoinss.link = req.body.link;

// 		addcoinss.save().then(updatedBlog => {
// 			req.flash("success_message", `Blog was successfully updated`);
// 			res.redirect("/partner/addcoin");
// 		});
// 	});
// });

// module.exports = partnerRouter;
