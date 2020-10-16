const express = require("express");
const router = express.Router();
const { userAuth } = require("../../helpers/authen");
const Loginuser = require("../../models/User");
const Detail = require("../../models/Detail");
const fs = require("fs");
const app = express();

//READ Blogs
router.get("/", (req, res) => {
	Loginuser.find({}).then(loginuser => {
		res.render("admin/loginuser", { loginuser: loginuser });
	});
});
//DELETE BLOG
router.delete("/:id", (req, res) => {
	Loginuser.findOne({ _id: req.params.id }).then(loginuser => {
		loginuser.remove().then(updatedBlogs => {
			req.flash("success_message", `delete successfully deleted`);
			res.redirect("/admin/loginuser");
		});
	});
});

module.exports = router;
