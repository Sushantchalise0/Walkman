module.exports = {
	partnerAuth: function(req, res, next) {
		if (req.session.partnerSuccess == "sandeepPartnerSession") {
			return next();
		}
		// req.username.partnerData
		res.redirect("/partner/login");
	}
};
