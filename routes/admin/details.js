const express = require('express');
const router = express.Router();
const {userAuth} = require('../../helpers/authen');
const Detail = require('../../models/Detail');
const Progress = require('../../models/Progress');

//READ USERS    
router.get('/', (req, res) => {
    var mysort = { user_name: 1 };
    Detail.find({}).sort(mysort).then(details => {

        res.render('admin/details/index', {details: details});
    }); 
});

//CREATE USERS
router.post('/create', (req, res) => {

    const newDetail = Detail({
        user_name: req.body.user_name
    });

    newDetail.save(savedDetail => { 
        const newProgres = Progress({
            distance: 0,
            coins: 50,
            detail: newDetail._id
        });
        newProgres.save(saved => {
            req.flash('progress also saved');
        });
        req.flash('success_message', `User successfully created`);
        res.redirect('/admin/details')        
    }); 
});


//DELETE CATEGORIES
router.delete('/:id', (req, res) => {

    Detail.findOne({_id: req.params.id})
    .then(details =>{

            details.remove().then(updatedDetail => {
            req.flash('success_message', `User successfully deleted`);
            res.redirect('/admin/details');
            });
    });
});

//GO TO EDIT
router.get('/edit/:id', (req, res) => {

    Detail.findOne({_id: req.params.id}).then(details => {
        

        res.render('admin/details/edit', {details: details});
    }); 
});

//UPDATE BLOG
router.put('/edit/:id', (req, res) => {

    Detail.findOne({_id: req.params.id}).then(details => {


       // blog.user = req.user.id;
        details.user_name = req.body.user_name;
        details.user_img = req.body.user_img;
        details.fb_id = req.body.fb_id;
        details.gender = req.body.gender;
        details.companyCode = req.body.companyCode;
        details.email = req.body.email;
        

        details.save().then(updatedDetail=> {

            req.flash('success_message', `Detail was successfully updated`);
            res.redirect('/admin/details');
        });
    });   
});
//added for USAID
router.get('/usaid', (req, res) => {
    var mysort = { user_name: 1 };
    Detail.find({companyCode:'USAIDNepal'}).sort(mysort).then(details => {

        res.render('admin/details/usaid', {details: details});
    }); 
});
//DELETE CATEGORIES
router.delete('/usaid/:id', (req, res) => {

    Detail.findOne({_id: req.params.id})
    .then(details =>{

            details.remove().then(updatedDetail => {
            req.flash('success_message', `User successfully deleted`);
            res.redirect('/admin/details/usaid');
            });
    });
});
//end For USAID
module.exports = router;


