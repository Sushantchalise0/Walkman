const express = require("express");
const router = express.Router();
const faker = require("faker");
const WalkmanUsers = require("../../models/Progress");
const Blog = require("../../models/Blogs");
const User = require("../../models/Detail");
const Vendor = require("../../models/Vendors");
const Products = require("../../models/Products");
const Coupons = require("../../models/Coupon");
const { userAuth } = require("../../helpers/authen");
const Progress = require("../../models/Progress");

router.all("/*", userAuth, (req, res, next) => {
	req.app.locals.layout = "admin";
	next();
});

router.get("/", (req, res) => {
	WalkmanUsers.count({}).then(walkmanCount => {
		Blog.count({}).then(blogCount => {
			Coupons.count({}).then(couponCount => {
				Products.count({}).then(productCount => {
					Vendor.count({}).then(vendorCount => {
						Coupons.find({ v_status: "true" })
							.count({})
							.then(redeemedCount => {
								Progress.find({}).then(WalkmanstepCount => {
									var datalen = WalkmanstepCount.length;
									var totalsteps = 0;
									for (var i = 0; i < datalen; i++) {
										totalsteps = totalsteps + WalkmanstepCount[i].distance;
									}
									res.render("admin/index", {
										walkmanCount: walkmanCount,
										blogCount: blogCount,
										couponCount: couponCount,
										productCount: productCount,
										vendorCount: vendorCount,
										redeemedCount: redeemedCount,
										WalkmanstepCount: totalsteps
									});
								});
							});
					});
				});
			});
		});
	});
});

router.post("/generate-fake-posts", (req, res) => {
	for (let i = 0; i < req.body.amount; i++) {
		let post = new POST();
		post.file = faker.image.nature();
		post.title = faker.name.title();
		post.status = "public";
		post.allowComments = faker.random.boolean();
		post.body = faker.lorem.sentence;

		post.save(function(err) {
			if (err) throw err;
		});
	}
	res.redirect("/admin/posts");
});

module.exports = router;
