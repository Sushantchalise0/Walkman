const express = require("express");
const app = express();
const path = require("path");
const Handlebars = require('handlebars');
const exphbs = require("express-handlebars");
const {allowInsecurePrototypeAccess} = require('@handlebars/allow-prototype-access'); //for deployment purpose only
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const upload = require("express-fileupload");
const session = require("express-session");
// const partnersession = require('express-session');
const flash = require("connect-flash");
const { mongoDbUrl } = require("./config/database");
const passport = require("passport");
// const partnerpassport = require('passport');
var fs = require("fs");
//const uuidv1 = require("uuid/v1");

const { v4: uuidv4 } = require('uuid');
uuidv4();

var sortBy = require("lodash").sortBy;
//vendor login
const bcrypt = require("bcryptjs");
//start for secure api
const morgan = require("morgan"),
	jwt = require("jsonwebtoken"),
	config = require("./config/config");

//end for secure api

mongoose
	.connect(mongoDbUrl, { useNewUrlParser: true })
	.then(db => {
		console.log("MONGO connected");
	})
	.catch(error => console.log(error));

app.use(express.static(path.join(__dirname, "public")));

//SET VIEW ENGINE
const { select, generateTime } = require("./helpers/handlebars-helpers");
app.engine(
	"handlebars",
	exphbs({
		defaultLayout: "home",
		helpers: { select: select, generateTime: generateTime },
		handlebars: allowInsecurePrototypeAccess(Handlebars)
	})
);
app.set("view engine", "handlebars");

//METHOD OVERRIDE
app.use(methodOverride("_method"));

//UPLOAD MIDDLEWARE
app.use(upload());

// BODY PARSER
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


    

//SESSIONS
app.use(
	session({
		secret: "sushantChaliseCodingCMS",
		resave: true,
		saveUninitialized: true
	})
);
//partnersession
// app.use(partnersession({

//     secret: 'sandeepMaharjanCodingCMS',
//     resave: true,
//     saveUninitialized: true
// }));

app.use(flash());

//PASSPORT
app.use(passport.initialize());
app.use(passport.session());

//LOCAL VARIABLES USING MIDDLEWARE
app.use((req, res, next) => {
	res.locals.user = req.user || null;
	res.locals.success_message = req.flash("success_message");
	res.locals.error_message = req.flash("error_message");
	res.locals.error = req.flash("error");
	next();
});

//LOAD ROUTES
let home = require("./routes/home/index");
let admin = require("./routes/admin/index");
let loginuser = require("./routes/admin/loginuser");
let blogs = require("./routes/admin/blogs");
let sponsers = require("./routes/admin/sponsers");
let details = require("./routes/admin/details");
let progresses = require("./routes/admin/porgresses");
let leaderboards = require("./routes/admin/leaderboards");
let coupons = require("./routes/admin/coupons");
let subprogress = require("./routes/admin/subprogress");
let vendors = require("./routes/admin/vendors");
let category = require("./routes/admin/category");
let vendorlog = require("./routes/admin/vendorlog");
let products = require("./routes/admin/products");
let featured = require("./routes/admin/featured");
let statements = require("./routes/admin/statements");
let addcoinpartner = require("./routes/partner/addcoin");
let loginpartner = require("./routes/partner/index");
//for secure api
const ProtectedRoutes = express.Router();

//USE ROUTES
app.use("/", home);
app.use("/admin", admin);
app.use("/admin/blogs", blogs);
app.use("/admin/loginuser", loginuser);
app.use("/admin/sponsers", sponsers);
app.use("/admin/details", details);
app.use("/admin/progresses", progresses);
app.use("/admin/leaderboards", leaderboards);
app.use("/admin/coupons", coupons);
app.use("/admin/subprogress", subprogress);
app.use("/admin/vendors", vendors);
app.use("/admin/category", category);
app.use("/admin/vendorlog", vendorlog);
app.use("/admin/products", products);
app.use("/admin/featured", featured);
app.use("/admin/statements", statements);
// app.use("/partner/addcoin", addcoinpartner);
// app.use("/partner", loginpartner);
//for secure api
app.use("/api", ProtectedRoutes);

//********************************************************************* */json secure api starts
//set secret
app.set("Secret", config.secret);

// use morgan to log requests to the console
app.use(morgan("dev"));

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// parse application/json
app.use(bodyParser.json());

app.post("/authenticate", (req, res) => {
	if (req.body.username === "walkman") {
		if (req.body.password === "walk9843089925") {
			// create token starts

			const payload = {
				check: true
			};

			var token = jwt.sign(payload, app.get("Secret"), {
				expiresIn: 1440 // expires in 24 hours
			});

			res.json({
				message: "authentication done ",
				token: token
			});
		} else {
			res.json({ message: "please check your password !" });
		}
	} else {
		res.json({ message: "user not found !" });
	}
});

ProtectedRoutes.use((req, res, next) => {
	// check header for the token
	var token = req.headers["access-token"];

	// decode token
	if (token) {
		// verifies secret and checks if the token is expired
		jwt.verify(token, app.get("Secret"), (err, decoded) => {
			if (err) {
				return res.json({ message: "invalid token" });
			} else {
				// if everything is good, save to request for use in other routes
				req.decoded = decoded;
				next();
			}
		});
	} else {
		// if there is no token

		res.send({
			message: "No token provided."
		});
	}
});


//FCM NOTIFICATION


module.exports = {
    notification : function(registrationToken, body) {
        var admins = require('firebase-admin');
    
        var serviceAccount = require('./android-db40e-firebase-adminsdk-7drt7-98c87c2544.json');
    
        var Token = registrationToken.fcm;

        admins.initializeApp({
            credential: admins.credential.cert(serviceAccount),
            databaseURL: 'https://android-db40e.firebaseio.com',
            });
    
        var payload = {
            notification:{
            title:'VisionCare',
            body: body
            },
            android: {
                notification: {
                    sound: 'default'
                },
            },
            apns: {
                payload: {
                    aps: {
                        sound: 'default'
                    },
                },
            },
            token: Token
        };
    
        admins.messaging().send(payload).then(
            function(response) {
                console.log('Successfully message sent:', response);
            })
            .catch(function(error) {
                console.log(error);
        });
    }
}

// var admins = require("firebase-admin");

// var serviceAccount = require("./walkmanv3fcm-sdk.json");

// admins.initializeApp({
//   credential: admins.credential.cert(serviceAccount)
// });


// const notification_options = {
//     priority: "high",
//     timeToLive: 60 * 60 * 24
//   };
// app.post('/firebase/notification', (req, res)=>{
//     const  registrationToken = req.body.registrationToken
//     const message = req.body.message
//     const options =  notification_options
    
//       admins.messaging().sendToDevice(registrationToken, message, options)
//       .then( response => {

//        res.status(200).send("Notification sent successfully")
       
//       })
//       .catch( error => {
//           console.log(error);
//       });

// });

//REQUIRE FOR API
const Blog = require("./models/Blogs");
const Sponser = require("./models/Sponsers");
const Detail = require("./models/Detail");
const Progress = require("./models/Progress");
const Coupon = require("./models/Coupon");
// const Test = require("./models/tests");
const Subprogress = require("./models/Subprogress");
const Vendor = require("./models/Vendors");
const Vendorlog = require("./models/Vendorlog");
const Category = require("./models/Category");
const Products = require("./models/Products");
const Featured = require("./models/Featured");
const Statement = require("./models/Statements");
const EmployeeDailyQuestionaire = require("./models/EmployeeDailyQuestionaire");
const EmployeeDailyQuestionaireProgress = require("./models/EmployeeDailyQuestionaireProgress");
const EmployeeActivityProgress = require("./models/EmployeeActivityProgress");
const EmployeeWeeklyQuestion = require("./models/EmployeeWeeklyQuestion");
const TreasureHuntQuestion = require("./models/TreasureHuntQuestion");
const SyncWeeklyProgressEmployee = require("./models/SyncWeeklyProgressEmployee");
const Unitss = require("./models/partner/Units");
const Vendors = require("./models/Vendors");
const BillingAddress = require("./models/BillingAddress");
const Cart = require("./models/Cart");

//API CUOPNS
app.get("/coupons", async (req, res) => {
	var coupon = await Coupon.find({}).sort({ _id: -1 });
	if (isEmptyObject(coupon)) {
		res.json({ coupon: {} });
	} else {
		res.json({ coupon });
	}
});

//API VERIFIED
// coupon verified from partner app
app.post("/verified", (req, res) => {
	var qrKey = req.body.qrKey;
	var vendorID = req.body.vendorID;
	var redeemed_dates = Date.now();

	//to add total coins in partners side
	Vendor.find({ _id: vendorID }).exec(function(err, vendd) {
		if (err) {
			res.json(err);
		} else {
			// console.log("i am here");
			// console.log(vendd[0]);
			Coupon.find({ qrKey: qrKey, vendorID: vendorID, v_status: "false" }).then(
				available => {
					if (isEmptyObject(available)) {
						res.status(404).send({ productObject: {} });
					} else {
						// console.log(available[0].productID);
						Products.find({
							vendor_id: vendorID,
							_id: available[0].productID
						}).then(
							productavailable => {
								//coin addition to vendor
								//    console.log(productavailable);
								//     console.log(productavailable[0]);
								var p_coins = productavailable[0].coins;
								// console.log(p_coins);
								var new_coins = vendd[0].total_coins - -p_coins;
								// console.log(new_coins);
								//total sales addition
								// console.log(productavailable[0]);
								var discprice = productavailable[0].disc_price;

								var newtotalsales = vendd[0].total_sales - -discprice;
								// console.log(newtotalsales);
								//totaldue
								var walkprice =
									productavailable[0].walkman_price -
									productavailable[0].disc_price;
								var newtotaldue = vendd[0].total_due - -walkprice;
								Vendor.findOneAndUpdate(
									{ _id: vendorID },
									{
										$set: {
											total_coins: new_coins,
											total_sales: newtotalsales,
											total_due: newtotaldue
										}
									},
									{ new: true },
									(err, doc) => {
										if (err) {
											console.log("error");
										} else {
											console.log("success");
										}
									}
								);
								//statement Partner
								// console.log(productavailable[0].disc_price);
								// console.log(walkprice);

								var newstate = new Statement({
									vendor_id: vendorID,
									product_id: available[0].productID,
									due: walkprice
								});
								newstate.save().then(
									doc => {
										console.log("saved statement");
									},
									e => {
										console.log("error statement");
									}
								);
							},
							e => {
								res.status(400).send(e);
							}
						);

						//     var newstate = new Statement({
						//         vendor_id: vendorID,
						//         product_id: productavailable[0].productID,
						//         due:  productavailable[0].disc_price
						//     });
						//     newstate.save().then((doc) => {
						//         console.log("saved statement");
						//     }, (e) => {
						//         console.log("error statement");
						//     });
						// }
						// });

						//end statemnt
					}
					//elseclosed
				}
			);
		}
	});

	//end to add total coins in partners side
	//  console.log(today.getDay());
	Coupon.find({ qrKey: qrKey, vendorID: vendorID, v_status: "false" }).then(
		available => {
			if (isEmptyObject(available)) {
				res.status(404).send({ productObject: {} });
			} else {
				Coupon.findOneAndUpdate(
					{ vendorID: vendorID, qrKey: qrKey, v_status: "false" },
					{ $set: { v_status: "true", redeemed_date: redeemed_dates } },
					{ new: true },
					(err, doc) => {
						if (err) {
							res.status(400).send({ productObject: {} });
						} else {
							Coupon.find({
								qrKey: qrKey,
								vendorID: vendorID,
								v_status: "true"
							})
								.populate("productID")
								.then(available => {
									if (isEmptyObject(available)) {
										res.send({ productObject: {} });
									} else {
										res.status(200).send({
											productObject: {
												name: available[0].productID.name,
												img: available[0].productID.img,
												coins: available[0].productID.coins,
												desc: available[0].productID.desc,
												date: available[0].productID.date,
												act_price: available[0].productID.act_price,
												disc_price: available[0].productID.disc_price,
												walkman_price: available[0].productID.walkman_price,
												status: available[0].productID.status,
												vendor_id: available[0].productID.vendor_id,
												ratings: available[0].productID.ratings
											}
										});
									}
								});
							// var productData = [];
							// var productdat = await Coupon.find({
							// 	qrKey: qrKey,
							// 	vendorID: vendorID,
							// 	v_status: "true"
							// }).populate("productID");

							// productdat.map(state => {
							// 	var body = {};
							// 	body.name = state.productID.name;
							// 	body.img = state.productID.img;
							// 	body.coins = state.productID.coins;
							// 	body.desc = state.productID.desc;
							// 	body.date = state.productID.date;
							// 	body.act_price = state.productID.act_price;
							// 	body.disc_price = state.productID.disc_price;
							// 	body.walkman_price = state.productID.walkman_price;
							// 	body.status = state.productID.status;
							// 	body.vendor_id = state.productID.vendor_id;
							// 	productData.push(body);
							// 	console.log(productData);
							// });
							// res.json({ productData });
						}
					}
				);
			}
		}
	);
});


//API TOKEN ACCESS GPI
app.post("/wp-json/wp/v2/getUserToken", (req, res) => {
	if (req.body.username === "walkman") {
		if (req.body.password === "walkman123") {
			
			res.json({
				token: "123",
				username: "walkman",
				email: "walkman@greencoins.com"
			});
		} else {
			res.json({ 
				"code": "unauthorized_access",
				"message": "Unauthorized Access",
				"data": {
					"status": 404
				}
			});
		}
	}
});


//API ALL USER DETAILS GPI
app.get("/users", async (req, res) => {
	var token = req.query.token;
	var page = req.query.page;
	var limit = 20;
	const skipIndex = (page-1) * limit;

	  if (token ==123 ){
		  var values = [];
		  var other = [];


		  let total = await Progress.find({})
		  .count();

		  var stat = await Progress.find({})
		  .limit(limit)
		  .skip(skipIndex)
		  .populate("detail")
		//   .exec(function(err, progress) {
		// 	if (err) {
		// 		res.json(err);
		// 	} else {
		// 		var datalen = progress.length;
		// 		console.log(datalen);
		// 	}
		// })
		;


		
	  stat.map(state => {

		  var body = {};
		  body.name = state.detail.user_name;
		  body.user_img = state.detail.user_img;
		  body.phone_number = state.detail.phone_number;
		  body.email_id = state.detail.email_id;
		  body.fb_id = state.detail.fb_id;
		  body.gender = state.detail.gender;
		  body.dob = state.detail.dob;
		  body.carbon_red = state.carbon_red;
		  body.progress = state.distance;
		  body.coins = state.coins;
		  values.push(body);
	  });
  		//console.log(total);
		  other.push({total:total, page:page});
	  	//values.push({total:total, page:page});
	  	res.json( {values,other});
	  
	  
	  
	  
	  
	  
			  }
	  else {
		  res.status(404).json({ 
		  
			  "code": "unauthorized_access",
			  "message": "Unauthorized Access",
			  "data": {
				  "status": 404
			  }
		  
		  });
	  }
  });


//API USER PROGRESS GPI
app.get("/progress", paginatedResults(), (req, res) => {
//	var detail = req.query.userid;
	var token = req.query.token;
	if (token ==123 ){
				//console.log(res.paginatedResults[1]);
				res.json(res.paginatedResults);
	
		}
	else {
		res.status(404).json({ 
		
			"code": "unauthorized_access",
			"message": "Unauthorized Access",
			"data": {
				"status": 404
			}
		
		});
	}
});


//PAGINATION FUNCTION
function paginatedResults() {
	return async (req, res, next) => {
	  var page = parseInt(req.query.page);
	  var limit = parseInt(req.query.limit);
	  //console.log(page, limit);
	  const skipIndex = (page - 1) * limit;
	  const results = {};
  
	  try {
		results.values = await Progress.find().populate('detail')
		  .sort({ _id: 1 })
		  .limit(limit)
		  .skip(skipIndex)
		  .exec();
		res.paginatedResults = results;
		console.log(results);
		next();
	  } catch (e) {
		res.status(500).json({ message: "Error Occured" });
	  }
	};
  }


  //api progress page
  app.get("/userinfo", async (req, res) => {
	  var token = req.query.token;
	  var limit = parseInt(req.query.limit);
	  var page = parseInt(req.query.page);
	  const skipIndex = (page - 1) * limit;
		if (token ==123 ){
			var values = [];

			var stat = await Progress.find()
			.limit(limit)
			.skip(skipIndex)
			.populate("detail");
		stat.map(state => {

			var body = {};
			body.name = state.detail.user_name;
			body.email_id = state.detail.email_id;
			body.fb_id = state.detail.fb_id;
			body.gender = state.detail.gender;
			body.dob = state.detail.dob;
			body.carbon_red = state.carbon_red;
			body.progress = state.distance;
			body.coins = state.coins;
			values.push(body);
		});
	
		res.send( {values});
		
		
		
		
		
				}
		else {
			res.status(404).json({ 
			
				"code": "unauthorized_access",
				"message": "Unauthorized Access",
				"data": {
					"status": 404
				}
			
			});
		}
	});


//API REEDEM
app.post("/getCoupons", (req, res) => {
	var detail = req.body.detail;
	Coupon.find({ detail })
		.populate("productID")
		.populate("vendorID")
		.then(
			redeem => {
				if (isEmptyObject(redeem)) {
					return res.send({ redeem });
				} else {
					res.send({ redeem });
				}
			},
			e => {
				res.status(400).send(e);
			}
		);
});
// coupon create in Coupons tab
app.post("/redeem/set", (req, res) => {



	var p_coins = req.body.p_coins;
	var detail = req.body.detail;
	var myid = new mongoose.Types.ObjectId()
	var coup = new Coupon({
		_id: myid,
		qrKey: myid,
		detail: req.body.detail,
		productID: req.body.productID,
		vendorID: req.body.vendorID
	});

	//var new_coins = u_coins - p_coins;

	Coupon.find({ detail })
		// .populate("progress")
		.populate("productID")
		.exec(function(err, cupon) {
			
			
			/******/
			//test
			var detail = req.body.detail;
			Progress.find({ detail: detail }).exec(function(err, progress) {
				if (err) {
					res.json(err);
				} else {
					// console.log((progress[0].coins)-(p_coins));
					var new_coins = progress[0].coins - p_coins;
					//test
					/******/
					if (new_coins >= 0) {
						Progress.findOneAndUpdate(
							{ detail: detail },
							{ $set: { coins: new_coins} },
							{ new: true },
							(err, doc) => {
								if (err) {
									res.send("Failed");
								} else {
									
									coup.save().then(
										// Coupon.findOneAndUpdate({id:myid},
										// 	{ $set: {qrKey: id}}),
										doc => {
											res.send("Success");
										},
										e => {
											res.status(400).send(e);
										}
									);
										

								}
							}
						);
					} else {
						
						res.send("Insufficient Coin");
					}
				}
			});
			


		});

		
	//    var p_coins = req.body.p_coins;
	//    var u_coins = req.body.u_coins;
	//    var detail = req.body.detail;
	//    var coup = new Coupon({
	//        detail: req.body.detail,
	//        qrKey: req.body.qrKey,
	//        productID: req.body.productID,
	//        vendorID:req.body.vendorID
	//    });

	//    var new_coins = u_coins - p_coins;
	//    Coupon.find({detail})
	//        // .populate("progress")
	//        .populate("productID")
	//        .exec(function(err, cupon) {
	//            Progress.findOneAndUpdate({detail: detail}, {$set:{coins:new_coins}}, {new: true}, (err, doc) => {
	//                if (err) {
	//                    res.send("0");
	//                }
	//                else{
	//                    coup.save().then((doc) => {
	//                    res.send("1");
	//                }, (e) => {
	//                    res.status(400).send(e);
	//                });
	//            }
	//            });
	//        });
});




//API GET USER
app.get("/details", (req, res) => {
	Detail.find().then(
		details => {
			res.send( details );
		},
		e => {
			res.send(400).send(e);
		}
	);
});

//API GET USER PROGRESS
app.get("/progress", (req, res) => {
	Progress.find().then(
		docs => {
			res.send({ docs });
		},
		e => {
			res.send(400).send(e);
		}
	);
});

//API FOR LEADERBOARD TOP 50
app.get("/leaderboard", function(req, res) {
	Progress.find({ distance: { $gt: 0 } }, "distance")
		.sort({ distance: -1 })
		.populate("detail")
		.exec(function(err, users) {
			if (err) {
				res.json(err);
			} else {
				res.json({ users });
			}
		});
});

//API FOR LEADERBOARD secured one
ProtectedRoutes.get("/leaderboardsecured", function(req, res) {
	Progress.find({ distance: { $gt: 0 } }, "distance")
		.sort({ distance: -1 })
		.populate("detail")
		.exec(function(err, users) {
			if (err) {
				res.json(err);
			} else {
				res.json({ users });
			}
		});
});

// //API FOR TEST LEADERBOARD
// app.get('/test', (req, res) => {
//     Progress.find().exec(function(err, prog) {
//         if (err) {
//           console.log('Error : ' + err);
//         } else {
//           if (prog != null) {
//               var obj1 = {meta: prog};
//             console.log(prog[1].detail);

//             Detail.find({})
//             // .then((details) => {
//             //     res.send({details});
//             // });
//             .exec(function(err, det) {
//                 var obj2 = {data: det};
//                 if (det != null) {
//                  res.send([obj1, obj2]);
//                   //res.send([prog[1], det]);
//                 }
//                 else {
//                   console.log('No jobs');
//                 }
//             });
//           } else {
//             console.log('No posts found');
//           }
//         }
//       });
//     Promise.all([
//         Progress.find().exec(), // returns a promise
//         Detail.find().exec() // returns a promise
//       ]).then(function(results) {
//         // results is [devDocs, jobs]
//           console.log(results);

//         res.send(results);

//       }).catch(function(err) {
//         res.send(err);
//       });
//   });
//   });


//API ADD NEW USERS 
app.post("/details/registration", (req, res) => {
	//var user_img = req.body.user_img;
	var email_id = req.body.email_id;
	var user_name = req.body.user_name;
	var phone_number = req.body.phone_number;
	var created_date = Date.now();

	var details = new Detail({
		user_name: user_name,
		phone_number: phone_number,
		email_id: email_id,
		created_date: created_date,
	});

	Detail.find({ email_id }).then(data => {
		//console.log((data));
		if (isEmptyObject(data)) {
			//return res.send("user doesnot exists");
			details.save().then(
				docs => {
					// console.log(details._id);
					var progresses = new Progress({
						detail: details._id,
						distance: 0,
						coins: 100
					});
					progresses.save().then(done => {
						res.status(200).send(docs);
					});
				},
				e => {
					res.status(400).send(e);
				}
			);  
		} else {
			console.log(data);
			return res.send("user exists");
		
	}
	});
});

//API TO CHECK IS USER EXISTS
// app.post("/userExists", (req, res) => {
// 	var email_id = req.body.email_id;

// 	Detail.find({ email_id },  {$set:{created_date:Date.now()}}, {new: true}).then(data => {
// 		// console.log((data));
// 		if (isEmptyObject(data)) {
// 			return res.send("false");
// 		} else {
// 			return res.send("true");
// 		}
// 	});
// });


app.post("/userExists", (req, res) => {
	var email_id = req.body.email_id;

	Detail.findOneAndUpdate({ email_id : email_id}, {$set:{created_date:Date.now()}}, {new: true}, (err, doc) => {
		if (err) {
			console.log("Something wrong when updating data!");
			return res.status(400).send("error");
		} else if(doc === null){
			console.log(doc);
			return res.send("false");
		} else {
			return res.send("true");
		}
	
		console.log(doc);
	});
});

//API GET ONES POSITION
app.get("/position/:id", (req, res) => {
	var detail = req.params.id;
	console.log(detail);
	Progress.find({ detail }).then(progresses => {
		var obj = JSON.stringify(progresses);
		  console.log(obj)
		 console.log(obj.substring(13, 14));
		var dis = parseInt(obj.substring(13, 22));
		console.log(dis);
		Progress.find({ distance: { $gt: dis } })
			.count(function(err, pos) {
				pos = pos + 1;
				if (!progresses) {
					return res.status(404).send();
				}
				res.json(pos);

				//console.log('your position is  %d', count);
				//});
			})
			.catch(e => {
				res.status(400).send();
			});
	});
});

//API GET PROGRESS
app.post("/progresses/getProgress", (req, res) => {
	var detail = req.body.detail;

	Progress.find({ detail }, 'distance calorie carbon_red')
		.then(progresses => {
			// console.log(detail);
			if (!progresses) {
				return res.status(404).send();
			}
			res.json( progresses );
		})
		.catch(e => {
			res.status(400).send();
		});
});

//API TO GETDETAIL
app.post("/details/getDetails", (req, res) => {
	var email_id = req.body.email_id;

	Detail.find( {email_id} ).then(
		data => {
			if (isEmptyObject(data)) {
				return res.status(204);
			} else {
				return res.send( data[0] );
			}
		},
		e => {
			res.status(400).send(e);
		}
	);
});


//API UPDATE USER DETAIL
app.post("/details/updateDetail", (req, res) => {
	// var _id = req.body._id;
	var email_id = req.body.email_id;
	var gender = req.body.gender;
	var user_name = req.body.user_name;
	var phone_number = req.body.phone_number;
	var dob = req.body.dob;
	var detail = new Detail({
		// fb_id: req.body.fb_id,
		gender: req.body.gender,
		user_name: req.body.user_name,
		phone_number: req.body.phone_number,
		dob : req.body.dob
	});
	Detail.findOneAndUpdate(
		{ email_id : email_id },
		{ $set: { gender: gender, user_name: user_name, phone_number: phone_number, dob: dob} },
		{ new: true },
		(err, doc) => {
			if (err) {
				res.send("error");
			}
			res.send("send");
		}
	);
});


//API TO SEND THE LAST UPDATED AND COINS FACTOR
app.get("/viewTime", (req, res) => {
	var detail = req.query.detail;
	//console.log(detail);
	var coin_factor = 0.001;
	Progress.find({detail: detail}, (err, doc) => {
	//	console.log(doc.length);
		if (err) {
			res.status(400).send("error");
		}
		else if(doc.length === 0) {
			res.status(404).send('Invalid User');
		}
		else {var last_updated = doc[0].last_updated;
		res.status(201).send({
			"coin_factor": coin_factor,
			"last_updated": last_updated
	})}
	});
});
	


app.post("/updateTime", (req, res) => {
	var last_updated = Date.now();
	var detail = req.body.detail;
	var distance = req.body.distance;
	var calorie = distance / 100;
	var coins = distance / 100;
	var carbon_red = distance * 35;
	Progress.findOneAndUpdate({detail: detail},
		{$set: {last_updated: last_updated}},
	{$new: true},
	(err, doc) => {
		if (err){
			res.status(400).send("error");
		}
		else if(doc.length === 0) {
			res.status(404).send('Invalid User');
		}
		else{
			doc.coins = parseInt(doc.coins) + parseInt(coins);
			doc.distance =  parseInt(doc.distance) + parseInt(distance);
			doc.calorie = parseInt(doc.calorie) + parseInt(calorie);
			doc.carbon_red = parseInt(doc.carbon_red) + parseInt(carbon_red);
			//doc.time = time;

			doc.save((error, updatedDoc) => {
				if (error) return handleError(err);
				//console.log(doc);
				res.status(201).send(doc);
			});
		
		}
		
	});
});


//API SET PROGRESS
app.post("/progresses/setProgress", (req, res) => {
	var detail = req.body.detail;
	var distance = req.body.distance;
	var start_time = req.body.start_time;
	var end_time = req.body.end_time;
	var time = {
		start_time: start_time,
		end_time: end_time,
		count: distance
	};
	//var doc ={};
	var calorie = distance / 100;
	var coins = distance / 100;
	var carbon_red = distance * 35;
	var prog = new Progress({
		detail: detail,
		distance: distance,
		calorie: calorie,
		coins: coins,
		carbon_red: carbon_red,
		time: time
	});
	if(detail === undefined) res.send('pass detail');
	else{ 
	Progress.findOneAndUpdate(
		 {detail: detail} ,
		 { $push: {time : time  } },
		// { $inc: { coins: coins, distance: distance, calorie: calorie, carbon_red: carbon_red } },
		// { $set: { coins: coins, distance: distance, calorie: calorie } },
		 //{ new: true },
		
		(err, doc) => {
			console.log(doc);
			if (err) {
				res.send("error");
			}
			else if(doc === null) {
				res.status(404).send('Invalid User');
			}
			else if(distance < 0) {
				res.send("null");
			}
			else{
			doc.coins = parseInt(doc.coins) + parseInt(coins);
			doc.distance =  parseInt(doc.distance) + parseInt(distance);
			doc.calorie = parseInt(doc.calorie) + parseInt(calorie);
			doc.carbon_red = parseInt(doc.carbon_red) + parseInt(carbon_red);
			//doc.time = time;

			doc.save((error, updatedDoc) => {
				if (error) return handleError(err);
				//console.log(doc);
				res.send(prog);
			});
		}
			
			//     prog.save().then((progresses) => {
			//         res.send(progresses);
			//     }, (e) => {
			//         res.status(400).send(e);
			//     });

			//     res.send('updated');
			// }).catch((e) => {
			//     res.status(400).send(e);
		}
	);
}
});



//API SET PROGRESS
app.post("/progresses/setProgress1", (req, res) => {
	var detail = req.body.detail;
	var distance = req.body.distance;
	var start_time = req.body.start_time;
	var end_time = req.body.end_time;
	var time = {
		start_time: start_time,
		end_time: end_time,
		count: distance
	};
	var calorie = distance / 100;
	var coins = distance / 100;
	var carbon_red = distance * 35;
	var prog = new Progress({
		detail: detail,
		distance: distance,
		calorie: calorie,
		coins: coins,
		carbon_red: carbon_red,
		time: time
	});

	Progress.update(
		{detail: detail} ,
		{ $push: {time : time  } },
	   { $inc: { coins: coins, distance: distance, calorie: calorie, carbon_red: carbon_red } },
		function(err, data){
			console.log(data);
			if(err) res.send("error");
			else res.send(prog);
		}
	);
	
});



//API TO SET BILLING ADDRESS

app.post("/Billing/setAddress", (req, res) => {
	var detail = req.body.detail;
	var fullName = req.body.fullName;
	var phoneNumber = req.body.phoneNumber;
	var province = req.body.province;
	var city = req.body.city;
	var address = req.body.address;
	var addrs = new BillingAddress({
		detail: detail,
		fullName: fullName,
		phoneNumber: phoneNumber,
		province: province,
		city: city,
		address: address
	});
	addrs.save().then(done => {
		if (done) {
			res.send(addrs);
		} else {
			res.send("error");
		}
	});
});


//API TO EDIT BILLING ADDRESS
app.post("/billing/updateAddress", (req, res) => {
	var _id = req.body.id;
	var fullName = req.body.fullName;
	var phoneNumber = req.body.phoneNumber;
	var province = req.body.province;
	var city = req.body.city;
	var address = req.body.address;
	var addrs = new BillingAddress({
		//detail: detail,
		fullName: fullName,
		phoneNumber: phoneNumber,
		province: province,
		city: city,
		address: address
	});
	BillingAddress.findByIdAndUpdate(
		{ _id: _id  },
		{ $set: { fullName: fullName, phoneNumber: phoneNumber, province: province, city: city, address: address} },
	//	{ new: true },
		(err, doc) => {
			if (err) {
				res.send("error");
			}
			res.send(doc);
		}
	);
});


//API GET ALL BILLING ADDRESS
app.get('/billing', (req, res) => {

	var detail = req.query.detail;
    BillingAddress.find({detail: detail})
    .then((addrs) => {
        res.send({addrs});
    }, (e) => {
        res.status(400).send(e);
    });
});


// API TO ADD TO CART

app.post("/Cart/addToCart", (req, res) => {
	var detail = req.body.detail;
	var productID = req.body.productID;
	//var myid = mongoose.Types.ObjectId();
	var cart = new Cart({
	//	_id: myid,
		detail: detail,
		productID: productID
	});
	Cart.updateOne(
		{ detail: detail}, 
		{ $push: { productID: productID  } },
		{upsert : true},
	   function (error, success) {
			 if (error) {
				 //console.log(error);
				 res.send(error);
			 } else {
				 //console.log(success);
				 res.send(cart)
			 }
		 });
	
});


// API TO REMOVE PRODUCT FORM A CART

app.post("/Cart/removeFromCart", (req, res) => {
	var detail = req.body.detail;
	var productID = req.body.productID;
	//var myid = mongoose.Types.ObjectId();
	var cart = new Cart({
	//	_id: myid,
		detail: detail,
		productID: productID
	});
	Cart.updateOne(
		{ detail: detail}, 
		{ $pull: { productID: productID  } },
		//{upsert : true},
	   function (error, success) {
			 if (error) {
				 //console.log(error);
				 res.send(error);
			 } else {
				 //console.log(success);
				 res.send(cart)
			 }
		 });
	
});


//API GET ALL PRODUCTS IN CART	
app.get('/cart', (req, res) => {

	 var detail = req.query.detail;
	 Cart.find({detail: detail})
	 .populate('productID') // multiple path names in one requires mongoose >= 3.6
    //  .exec(function(err, usersDocuments) {
	// 	res.send(usersDocuments);
    // });
    .then((Cart) => {
        res.send({Cart});
    }, (e) => {
        res.status(400).send(e);
    });
});


//API TO SEARCH PRODUCT OF A PARTICULAR VENDOR

app.get('/vendorProductSearch', function(req, res){

	var vendor = req.query.vendor_id;
	var product = req.query.product_name

			var regex = new RegExp(product, 'i');
			Products.find({
				// $and: [
				// 	{
				vendor_id: vendor,
				name : regex
			// }			]
			}, function(err, result) {
				if (err) throw err;
				if (result) {
					res.json(result)
				} else {
					res.send(JSON.stringify({
						error : 'Error'
					}))
				}
			})
});


//API TO FIND ALL PRODUCTS OF A PARTICULAR CATEGORY

app.get('/categoryAllProduct', function(req, res){

	var category = req.query.cat_id;

			Vendors.find({
				// $and: [
				// 	{
				cat_id: category
			// }			]
			}, function(err, result) {
				if (err) throw err;
				if (result) {
					res.json(result)
				} else {
					res.send(JSON.stringify({
						error : 'Error'
					}))
				}
			})
});


//API TO FIND ALL PRODUCTS OF A PARTICULAR VENDOR

app.get('/vendorAllProduct', function(req, res){

	var vendor = req.query.vendor_id;

			Products.find({
				// $and: [
				// 	{
				vendor_id: vendor
			// }			]
			}, function(err, result) {
				if (err) throw err;
				if (result) {
					res.json(result)
				} else {
					res.send(JSON.stringify({
						error : 'Error'
					}))
				}
			})
});


//API TO FIND A VENDOR OF A PARTICULAR PRODUCT

app.get('/vendorOfProduct', function(req, res){

	var product = req.body.product_id;

			Products.findOne({_id: product}).exec(function(err, result) {
				if (err) return;
				if (result) {
					console.log(result);
					var thisID = result.vendor_id;
					console.log(thisID);
						Vendor.find({ _id : thisID}).exec(function(err1, vendors) {
							if (err1) {
								res.json(err1);
							} else {
								res.json( vendors );
							}
						});
				} else {
					res.send(JSON.stringify({
						error : 'Error'
					}))
				}
			})
		
	
});


//API TO SERRCH VENDORS

app.get('/vendorSearch', function(req, res) {
	var query = req.query.vendor_name;
	
	
	var regex = new RegExp(query, 'i');

	
    Vendors.find({
        vendor_name : regex
    }, function(err, result) {
        if (err) throw err;
        if (result) {
            res.json(result)
        } else {
            res.send(JSON.stringify({
                error : 'Error'
            }))
        }
    })
})


//API TO SERRCH ALL PRODUCTS

app.get('/productSearch', function(req, res) {
	var query = req.query.product_name;
	
	
	var regex = new RegExp(query, 'i');

	
    Products.find({
        name : regex
    }, function(err, result) {
        if (err) throw err;
        if (result) {
            res.json(result)
        } else {
            res.send(JSON.stringify({
                error : 'Error'
            }))
        }
    })
})


app.get("/subtest", function(req, res) {
	Subprogress.find({})
		.sort({ _id: -1 })
		//.populate("detail")
		//.populate("sponser")
		.exec(function(err, subprogress) {
			if (err) {
				res.json(err);
			} else {
				res.json({ subprogress });
			}
		});
});

// //API ADD USER SUB PROGRESS daily
//need detail id, date and distance in array in object subprogress
app.post("/subprogress", (req, res) => {
	var obj = Object.keys(req.body.subprogress).length;
	var docs = [];
	for (var i = 0; i < obj; i++) {
		docs[i] = req.body.subprogress[i];
		const subprogress = new Subprogress({
			distance: docs[i].distance,
			date: docs[i].date,
			detail: docs[i].detail
		});
		var det = subprogress.detail;
		var dist = subprogress.distance;
		var dat = subprogress.date;
		//    console.log(det,dist,dat);

		Subprogress.find({ detail: det, date: dat }).then(available => {
			if (isEmptyObject(available)) {
				subprogress.save().then(done => {
					if (done) {
						res.end("1");
					} else {
						res.end("0");
					}
				});
			} else {
				Subprogress.findOneAndUpdate(
					{ detail: det, date: dat },
					{ $set: { distance: dist } },
					{ new: true },
					(err, doc) => {
						if (err) {
							res.end("0");
						} else {
							res.end("1");
						}
					}
				);
			}
		});
		//    Subprogress.findOneAndUpdate({detail:det,date:dat,distance:dist}, {$set:{detail:det,date:dat,distance:dist}}, {new: true}, (err, doc) => {
		//     if (err) {
		//         console.log(det);
		//    console.log(dist);
		//    console.log(dat);
		//         subprogress.save().then((done) => {
		//             if(done){
		//                 res.send("1");
		//             }
		//             else{
		//                 res.send("0");
		//             }
		//         });
		//     }
		//     });
	}
	// // //systemdate
	// // var datetime = new Date();
	// // var dateSystem=datetime.toISOString().slice(0,10);
	// // //systemdate
	//     var date= req.body.date;
	//     var detail= req.body.detail;
	//     var distance= req.body.distance;
	//         Subprogress.findOneAndUpdate({date:date, detail:detail}, {$set:{distance:distance}}, {new: true}, (err, doc) => {

	//             if(isEmptyObject(doc)) {
	//                 subprogress.save().then((docs) => {
	//                             res.send(docs);
	//                         }, (e) => {
	//                             res.status(400).send(e);
	//                         });
	//                  }
	//             else{
	//                 res.send("updated");
	//              }
	//          });
});


// app.post("/subprogress", async (req, res) => {
// 	try {
// 	  var dft = req.body.subProgress;
// 	  //console.log(dft);
// 	  //var databody = dft.replace(/\\/g, "");
// 		//var databody=req.body;
// 	  var fg = JSON.parse(dft);
// 	  console.log(fg);
  

// 	  var obj = fg.subProgress.length;
// 	  var docs = [];
// 	  var dist = "";
// 	  var dat = "";
// 	  var forcount = 0;
// 	  for (var i = 0; i < obj; i++) {
// 		docs[i] = fg.subProgress[i];
// 		const subprogressLoop = new Subprogress({
// 		  distance: docs[i].distance,
// 		  date: docs[i].date,
// 		  detail: fg.detail,
// 		});
// 		var det = fg.detail;
// 		var dist = docs[i].distance;
// 		var dat = docs[i].date;

// 		await Subprogress.findOneAndUpdate(
// 		  {
// 			detail: det,
// 			date: dat,
// 		  },
// 		  {
// 			$set: {
// 			  distance: dist,
// 			},
// 		  },
// 		  { new: true },
// 		  (err, doc) => {
// 			//		console.log(doc);
// 			if (doc == null) {
// 			  console.log("inside error");
// 			  subprogressLoop.save();
// 			} else {
// 			  console.log("update success");
// 			}
// 		  }
// 		);
// 		// console.log("after looped");
// 		forcount++;
// 		//console.log(forcount);
// 	  }
// 	  if (obj == forcount) {
// 		var body = {};
// 		body.result = "1";
// 		body.message = "Successfully synced daily data";
// 		res.json(body);
// 	  } else {
// 		var body = {};
// 		body.result = "0";
// 		body.message = "Failed to synced daily data";
// 		res.json(body);
// 	  }
// 	} catch (err) {
// 	  var body = {};
// 	  body.result = "0";
// 	  body.message = "Failed to synced daily data (From Catch)";
// 	  res.json(body);
// 	}
//   });
  


// //API user PROGRESS weekly
app.post("/progressweek", (req, res) => {
	var userid = req.body.detail;
	Subprogress.find({ detail: userid })
		.sort({ date: -1 })
		.limit(7)
		.exec(function(err, users) {
			if (err) {
				res.json(err);
			} else {
				res.json({ users });
			}
		});
});
//old vendor login and get details
// app.post("/vendorlogin", (req, res) => {
// 	var username = req.body.username;
// 	var password = req.body.password;
// 	Vendorlog.find({ username, password }).then(
// 		vendorlog => {
// 			if (isEmptyObject(vendorlog)) {
// 				return res.send({ vendors: {} });
// 			} else {
// 				var rama = vendorlog[0].vendor_id;
// 				Vendor.findOne({ _id: rama }).then(
// 					vendors => {
// 						if (isEmptyObject(vendors)) {
// 							return res.send({ vendors: {} });
// 						} else {
// 							res.send({ vendors: vendors });
// 						}
// 					},
// 					e => {
// 						res.status(400).send(e);
// 					}
// 				);
// 			}
// 		},
// 		e => {
// 			res.status(400).send(e);
// 		}
// 	);
// });

//new vendor login and get details
app.post("/vendorlogin", (req, res) => {
	var username = req.body.username;
	var password = req.body.password;

	Vendorlog.findOne({ username: username }).then(vendorlog => {
		// console.log(vendorlog);
		// console.log(vendorlog.password);
		if (isEmptyObject(vendorlog)) {
			return res.status(400).send({ vendors: {} });
		} else {
			// console.log("I am here");
			// console.log(password);
			// console.log(vendorlog.password);
			// var data = bcrypt.stringify(vendorlog.password);
			// console.log(data);
			bcrypt.compare(password, vendorlog.password, (err, matched) => {
				if (err) return res.status(400).send({ vendors: {} });

				if (matched) {
					// console.log("matched password from Vendor");
					var rama = vendorlog.vendor_id;
					Vendor.findOne({ _id: rama }).then(vendors => {
						if (isEmptyObject(vendors)) {
							return res.status(400).send({ vendors: {} });
						} else {
							res.status(200).send({ vendors: vendors });
						}
					});
				} else {
					return res.status(400).send({ vendors: {} });
				}
			});
		}
	});
});

//API categories=>vendor
// app.get('/categories', function(req, res) {
// Category.aggregate([
//         { $lookup:
//            {
//              from: 'vendors',
//              localField: '_id',
//              foreignField: 'cat_id',
//              as: 'vendors'
//            }
//         }
//     ])
// .then(category => {
//     if (!category) {
//         return res.status(404).send();
//     }
//     res.json({category});
// }).catch((e) => {
//     res.status(400).send();
// });
// });
//API vendor=>products
// app.get('/vendors', function(req, res) {
//  Vendor.aggregate([
//     { $lookup:
//        {
//          from: 'products',
//          localField: '_id',
//          foreignField: 'vendor_id',
//          as: 'products'
//        }
//      }
//     ])
// .then(vendors => {
// if (!vendors) {
//     return res.status(404).send();
// }
// res.json({vendors});
// }).catch((e) => {
// res.status(400).send();
// });

// });
//API FEATURED
app.get("/featured", function(req, res) {
	Featured.find({})
		.sort({ _id: -1 })
		//.populate("detail")
		//.populate("sponser")
		.exec(function(err, featured) {
			if (err) {
				res.json(err);
			} else {
				res.json( featured );
			}
		});
});
//API CATEGORY
app.use("/categories", function(req, res) {
	Category.find({}).exec(function(err, categories) {
		if (err) {
			res.json(err);
		} else {
			res.json( categories );
		}
	});
});
//API VENDORS
app.get("/vendors", function(req, res) {
	Vendor.find({}).exec(function(err, vendors) {
		if (err) {
			res.json(err);
		} else {
			res.json( vendors );
		}
	});
});
//API products
app.get("/products", async (req, res) => {
	var prod = await Products.find({});
	var products = [];
	prod.map(proddata => {
		var body = {};
		body.name = proddata.name;
		body.img = proddata.img;
		body.coins = proddata.coins;
		body.desc = proddata.desc;
		body.act_price = "Rs. " + proddata.act_price;
		body.disc_price = "Rs. " + proddata.disc_price;
		body.status = proddata.status;
		body.walkman_price = "Rs. " + proddata.walkman_price;
		body._id = proddata._id;
		body.vendor_id = proddata.vendor_id;
		body.ratings = proddata.ratings;
		products.push(body);
	});

	res.json( products );
});




// //API products
// app.get("/products", function(req, res) {
// 	Products.find({}).exec(function(err, products) {
// 		if (err) {
// 			res.json(err);
// 		} else {
// 			res.json({ products });
// 		}
// 	});
// });

//API total steps in db
app.post("/userProfile", function(req, res) {
	var detail = req.body.detail
	
	Progress.find({}).exec(function(err, progress) {
		if (err) {
			res.json(err);
		} else {
			var user_step = 0;
			var datalen = progress.length;
			var totalsteps = 0;
			var totalcoins = 0;
			var user_coins = 0;
			var pos ;
			var carbon_red;
			
			for (var i = 0; i < datalen; i++) {
				totalsteps = totalsteps + progress[i].distance;
				totalcoins = totalcoins + progress[i].coins;
				if(progress[i].detail == detail) {
					var dis = progress[i].distance;
					console.log(dis);
					
					user_step = progress[i].distance;
					user_coins = progress[i].coins;
					carbon_red = user_step * 35;
					console.log(user_step);	
					console.log(carbon_red);
				}
			}
			Progress.find({ distance: { $gt: dis } }).count(function(err, position) {
						pos = ++position;
					
				res.status(201).send({
				"user_step": user_step,
				"total_step": totalsteps,
				"total_coins": totalcoins,
				"user_coins": user_coins,
				"position": pos,
				"carbon_reduced": carbon_red
			})
		});


		}
	});
});

//API total green coins in db
app.get("/totalgreencoins", function(req, res) {
	Progress.find({}).exec(function(err, progress) {
		if (err) {
			res.json(err);
		} else {
			var datalen = progress.length;
			var totalcoins = 0;
			for (var i = 0; i < datalen; i++) {
				totalcoins = totalcoins + progress[i].coins;
			}
			res.json({ totalcoins });
		}
	});
});

//API for bestdeals products
app.get("/bestdeals", async (req, res) => {
	var prod = await Products.find({
		
	})
	.sort({ walkman_price : -1 })
	;
	var products = [];
	prod.map(proddata => {
		var body = {};
		body.name = proddata.name;
		body.img = proddata.img;
		body.coins = proddata.coins;
		body.desc = proddata.desc;
		body.act_price = "Rs. " + proddata.act_price;
		body.disc_price = "Rs. " + proddata.disc_price;
		body.status = proddata.status;
		body.walkman_price = "Rs. " + proddata.walkman_price;
		body._id = proddata._id;
		body.vendor_id = proddata.vendor_id;
		body.ratings = proddata.ratings;
		products.push(body);
	});

	res.json( products );
});



//statements
app.post("/getStatement", async (req, res) => {
	var vendor_id = req.body.vendorID;
	var statements = [];

	var stat = await Statement.find({ vendor_id: vendor_id })
		.sort({ redeemedDate: -1 })
		.populate("product_id");
	stat.map(state => {
		var body = {};
		body.name = state.product_id.name;
		body.img = state.product_id.img;
		body.coins = state.product_id.coins;
		body.disc_price = state.product_id.disc_price;
		body.due = state.due;
		body.redeemedDate = state.redeemedDate;
		body.redeemedTime = state.redeemedTime;
		statements.push(body);
	});

	res.json({ statements });
	// }
	// Statement.find({vendor_id:vendor_id}).sort({redeemedDate: -1})
	// .exec(function(err, statement) {
	//     if(err) {
	//         res.json(0);
	//     } else {
	//         Products.find({vendor_id:vendor_id}).exec(function(err, prostatement) {
	//             var datalen=statement.length;
	//             console.log(datalen);
	//             // do this to send json to certain own object
	//             //own object creating method using for loop
	//             var statements = [];
	//             for (var i=0;i<datalen;i++)
	//             {
	//                      var stst={name:prostatement[i].name,img: prostatement[i].img,due:statement[i].due,coins:prostatement[i].coins,
	//                         disc_price:prostatement[i].disc_price,redeemedDate:statement[i].redeemedDate,redeemedTime:statement[i].redeemedTime
	//                     };
	//                     statements.push(stst);
	//             }
	//             // console.log(statements);
	//             //res.send({sandeep});
	//             res.send({statements});
	//         });
	//     }
	// });
});

//specific vendor detail
app.get("/getPartnerVendor", (req, res) => {
	var vendor_id = req.body.vendor_id;
	Vendor.findOne({_id : vendor_id }).exec(function(err, vendorPartner) {
		if (err) {
			res.json(0);
		} else {
			res.json( vendorPartner );
		}
	});
});

//API ADD PRODUCTS
app.post("/adwalkmnproducts", (req, res) => {
	//to convert base64 image to file
	//base64 image string
	var base64String = req.body.baseString;
	var ranuid = uuidv1();
	console.log(ranuid);
	const path = "./public/uploads/products/";
	let base64Image = base64String.split(";base64,").pop();
	fs.writeFile(
		path + "partner-" + ranuid + ".png",
		base64Image,
		{ encoding: "base64" },
		function(err) {
			console.log("File created");
			console.log(path + "partner-" + ranuid + ".png");
		}
	);
	//end base64 image conversion

	var imgDb = "/uploads/products/" + "partner-" + ranuid + ".png";
	var vendor_id = req.body.vendorID;
	var name = req.body.name;
	var act_price = req.body.act_price;
	var disc_price = req.body.disc_price;
	var desc = req.body.desc;

	var partnerProducts = new Products({
		vendor_id: vendor_id,
		name: name,
		img: imgDb,
		act_price: act_price,
		disc_price: disc_price,
		desc: desc
	});
	partnerProducts.save().then(done => {
		if (done) {
			res.send("1");
		} else {
			res.send("0");
		}
	});
});

//API FOR LEADERBOARD TOP 50 with position
app.post("/leaderboardtest", function(req, res) {
	var detail = req.body.detail;
	Progress.find({}, "distance")
		.sort({ distance: -1 })
		.limit(50)
		.populate("detail")
		.exec(function(err, users) {
			if (err) {
				res.json(err);
			} else {
				Progress.find({}, "distance")
					.sort({ distance: -1 })
					.populate("detail")
					.exec(function(err, data) {
						var datalen = data.length;
						var count = 0;
						for (var i = 0; i < datalen; i++) {
							// console.log(data[i].detail._id);
							count = count + 1;
							if (data[i].detail._id == detail) {
								// console.log(data[i].detail._id);
								var detailid = data[i].detail;
								var userid = data[i]._id;
								var distance = data[i].distance;
								break;
							}
						}
						//console.log(userid);
						//console.log(username);
						//console.log(distance);

						// console.log(count);
						if (count <= 50) {
							res.send({ users });
						} else {
							var userpos = {
								distance: distance,
								_id: userid,
								detail: detailid,
								position: count
							};
							users.push(userpos);
							// var yy=users;
							//  var tt=merge(userpos,yy);
							// var tt=Object.assign({userpos},yy);
							// res.send(userpos);
							res.send({ users });
						}
					});
				// res.json({users});
			}
		});
});
//******************************************** */json secure api ends

//start for USAID or Employee version of WALKMAN green COins

// app.get('/EDQuestionaire', (req, res) => {
//     EmployeeDailyQuestionaire.find().then((docs) => {
//         res.send({docs});
//     }, (e) => {
//         res.send(400).send(e);
//     });
// });
// app.get('/EDQProgress', (req, res) => {
//     EmployeeDailyQuestionaireProgress.find().then((docs) => {
//         res.send({docs});
//     }, (e) => {
//         res.send(400).send(e);
//     });
// });

//Post of Employee daily question
// app.post('/EDQPost', (req, res) => {
//     var EDQPosting = new EmployeeDailyQuestionaire({
//         question: req.body.question,
//         ansOne: req.body.ansOne,
//         ansTwo: req.body.ansTwo,
//         ansThree:req.body.ansThree,
//         ansFour:req.body.ansFour,
//         ansOneCoins: req.body.ansOneCoins,
//         ansTwoCoins: req.body.ansTwoCoins,
//         ansThreeCoins:req.body.ansThreeCoins,
//         ansFourCoins:req.body.ansFourCoins
//     });
//     EDQPosting.save().then((done) => {
//         if(done){
//             res.send("1");
//         }
//         else{
//             res.send("0");
//         }
//     });
// });
//employee activity question progress post
app.post("/EAQPPost", (req, res) => {
	var EAQPPosting = new EmployeeDailyQuestionaireProgress({
		detail: req.body.detail,
		question_id: req.body.question_id,
		answer: req.body.answer,
		coins: req.body.coins
	});
	EAQPPosting.save().then(done => {
		if (done) {
			res.send("1");
		} else {
			res.send("0");
		}
	});
});
//get employee activity progress
app.get("/EAProgress", (req, res) => {
	EmployeeActivityProgress.find()
		.populate("detail")
		.then(
			docs => {
				res.send({ docs });
			},
			e => {
				res.send(400).send(e);
			}
		);
});
//employee weekly question get
app.get("/EWQGet", (req, res) => {
	EmployeeWeeklyQuestion.find().then(
		docs => {
			res.send({ docs });
		},
		e => {
			res.send(400).send(e);
		}
	);
});
//employee weekly question post
app.post("/EWQPost", (req, res) => {
	var EWQPosting = new EmployeeWeeklyQuestion({
		question: req.body.question,
		coins: req.body.coins
	});
	EWQPosting.save().then(done => {
		if (done) {
			res.send("1");
		} else {
			res.send("0");
		}
	});
});
//employee activity progresspost
app.post("/EAPPost", (req, res) => {
	var detailvv = req.body.detail;
	var walkCoinsvv = req.body.walkCoins;
	var treasureHuntCoinsvv = req.body.treasureHuntCoins;
	var weeklyActivityCoinsvv = req.body.weeklyActivityCoins;
	var WTWACoinsvv =
		req.body.walkCoins -
		-req.body.treasureHuntCoins -
		-req.body.weeklyActivityCoins;
	var EAPPosting = new EmployeeActivityProgress({
		detail: detailvv,
		walkCoins: walkCoinsvv,
		treasureHuntCoins: treasureHuntCoinsvv,
		weeklyActivityCoins: weeklyActivityCoinsvv,
		WTWACoins: WTWACoinsvv
	});

	EmployeeActivityProgress.find({ detail: detailvv }).then(available => {
		if (isEmptyObject(available)) {
			EAPPosting.save().then(done => {
				if (done) {
					res.send("1");
				} else {
					res.send("0");
				}
			});
		} else {
			EmployeeActivityProgress.findOneAndUpdate(
				{ detail: detailvv },
				{
					$set: {
						walkCoins: walkCoinsvv,
						treasureHuntCoins: treasureHuntCoinsvv,
						weeklyActivityCoins: weeklyActivityCoinsvv,
						WTWACoins: WTWACoinsvv
					}
				},
				{ new: true },
				(err, doc) => {
					if (err) {
						res.send("0");
						console.log("i am here 2");
					} else {
						res.send("1");
					}
				}
			);
		}
	});
});
//Treasure Hunt question get
// app.get('/TreasureHuntGet', (req, res) => {
//     TreasureHuntQuestion.find().then((docs) => {
//         res.send({docs});
//     }, (e) => {
//         res.send(400).send(e);
//     });
// });
// //Post of Treasure Hunt question
// app.post('/TreasureHuntPost', (req, res) => {
//     var TreasureHuntPosting = new TreasureHuntQuestion({
//         question: req.body.question,
//         ansOne: req.body.ansOne,
//         ansTwo: req.body.ansTwo,
//         ansThree:req.body.ansThree,
//         ansFour:req.body.ansFour,
//         correctAnswer: req.body.correctAnswer,
//         coins: req.body.coins
//     });
//     TreasureHuntPosting.save().then((done) => {
//         if(done){
//             res.send("1");
//         }
//         else{
//             res.send("0");
//         }
//     });
// });
//get syncweekly data
app.get("/syncweeklydata", (req, res) => {
	SyncWeeklyProgressEmployee.find().then(
		weeklyProgress => {
			if (isEmptyObject(weeklyProgress)) {
				return res.send({ weeklyProgress: {} });
			} else {
				res.send({ weeklyProgress });
			}
		},
		e => {
			res.send(400).send(e);
		}
	);
});
//Sync Weekly Usaid Employee Progress using object
app.post("/syncweeklyprogress", (req, res) => {
	var obj = Object.keys(req.body.weeklyProgress).length;
	var docs = [];
	for (var i = 0; i < obj; i++) {
		docs[i] = req.body.weeklyProgress[i];
		const syncweekly = new SyncWeeklyProgressEmployee({
			question_id: docs[i].question_id,
			coins: docs[i].coins,
			status: docs[i].status,
			weekNo: docs[i].weekNo,
			detail: docs[i].detail
		});
		syncweekly.save().then(done => {
			if (done) {
				res.send("1");
			} else {
				res.send("0");
			}
		});
	}
});
//single data employee activity progresspost
app.post("/singleEAPdata", (req, res) => {
	var detailvv = req.body.detail;

	EmployeeActivityProgress.findOne({ detail: detailvv }).exec(function(
		err,
		available
	) {
		if (err) {
			res.send({ available: {} });
		} else {
			res.send({ available });
		}
	});
});
//single data weekly sync data
app.post("/singleWeeklydata", (req, res) => {
	var detailvv = req.body.detail;

	SyncWeeklyProgressEmployee.find({ detail: detailvv }).exec(function(
		err,
		available
	) {
		if (err) {
			res.send({ available: {} });
		} else {
			res.send({ available });
		}
	});
});

//secured get employee activity progress
ProtectedRoutes.get("/EmployeeActivityProgress", (req, res) => {
	EmployeeActivityProgress.find()
		.populate("detail", "user_img user_name")
		.exec(function(err, USAIDEAP) {
			if (err) {
				res.send({ USAIDActivity: {} });
			} else {
				var EmployeeActivity = sortBy(USAIDEAP, "WTWACoins").reverse();
				console.log(EmployeeActivity);
				delete EmployeeActivity["walkCoins"];
				//  delete EmployeeActivity ['walkCoins'];
				//  delete EmployeeActivity ['treasureHuntCoins'];
				res.send({ EmployeeActivity });
			}
		});
});
//API FOR LEADERBOARD secured one
ProtectedRoutes.get("/EmployeeLeaderboard", function(req, res) {
	// var statements = [];
	Detail.find({ companyCode: "USAIDNepal" }).exec(function(err, detailusers) {
		if (err) {
			res.send("0");
		} else {
			// console.log(detailusers[0]._id);
			//  res.json(detailusers[0]._id);

			var datalen = detailusers.length;
			// do this to send json to certain own object
			//own object creating method using for loop
			var leaderboardUSAID = [];
			for (var i = 0; i < datalen; i++) {
				var number = 0;
				Progress.find({ detail: detailusers[i]._id })
					//to populate selected data only
					.populate("detail", "user_img user_name")
					.exec(function(err, users) {
						if (err) {
							res.send("0");
						} else {
							// getcallhawa(users[0]);
							leaderboardUSAID.push(users[0]);
							// console.log(users[0]);
							// console.log(dataa);

							//    console.log(i);
							//    console.log(datalen);
						}
						number++;
						if (number == datalen) {
							var EmployeeLeaderboard = sortBy(
								leaderboardUSAID,
								"distance"
							).reverse();
							res.send({ EmployeeLeaderboard });
							// console.log(leaderboardUSAID);
							// console.log(datalen);
						}
					});
			}
			//end for
		}
		//end else
	});
});

//  var datalen=statement.length;
//  // do this to send json to certain own object
//  //own object creating method using for loop
//  var statements = [];
//  for (var i=0;i<datalen;i++)
//  {
//           var stst={name:prostatement[i].name,img: prostatement[i].img,due:statement[i].due,coins:prostatement[i].coins,
//              disc_price:prostatement[i].disc_price,redeemedDate:statement[i].redeemedDate,redeemedTime:statement[i].redeemedTime
//          };
//          statements.push(stst);
//  }
//  // console.log(statements);
//  //res.send({sandeep});
//  res.send({statements});

//detail test
app.post("/detailadd", (req, res) => {
	var EAQPPosting = new Detail({
		user_name: req.body.user_name,
		user_img: req.body.user_img,
		fb_id: req.body.fb_id,
		companyCode: req.body.companyCode,
		email: req.body.email,
		gender: "male"
	});
	console.log(EAQPPosting);
	EAQPPosting.save().then(done => {
		if (done) {
			res.send("1");
		} else {
			res.send("0");
		}
	});
});

//API ADD USER PROGRESS
app.post("/addpartnerunit", (req, res) => {
	var unitdata = new Unitss({
		unit: req.body.unit
	});

	unitdata.save().then(
		docs => {
			res.send(docs);
		},
		e => {
			res.status(400).send(e);
		}
	);
});

// //Data if Details and progress not matched
// app.get("/getDataNW", async (req, res) => {
// 	var detaa = await Detail.find({});
// 	var Porg = await Progress.find({});
// 	var fork = [];
// 	if (isEmptyObject(detaa)) {
// 		console.log("empty");
// 	} else {
// 		detaa.map(state => {
// 			var body = {};
// 			body._id = state._id;

// 			Porg.map(dar => {
// 				var dcf = {};
// 				dcf._id = dar.detail;
// 				// console.log(dcf._id);
// 				if (body._id != dcf._id) {
// 					console.log(body._id);
// 					// console.log(dcf._id);
// 				} else {
// 					console.log("all are equal");
// 				}
// 			});
// 			// fork.push(body);
// 		});
// 		// console.log(fork);
// 		// fork.map(dar=>{
// 		// 	var body={};
// 		// 	body._id=dar._id;

// 		// });

// 		// var Porg = await Progress.find({});
// 		// console.log(Porg);
// 	}
// });
//FUNCTION TO CHECK IF OBJECT IS EMPTY
function isEmptyObject(obj) {
	return !Object.keys(obj).length;
}

// This should work both there and elsewhere.
function isEmptyObject(obj) {
	for (var key in obj) {
		if (Object.prototype.hasOwnProperty.call(obj, key)) {
			return false;
		}
	}
	return true;
}

const port = process.env.PORT || 4500;

app.listen(port, () => {
	console.log(`listening on port ${port}`);
});
