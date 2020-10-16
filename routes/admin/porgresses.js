const express = require('express');
const router = express.Router();
const Progress = require('../../models/Progress');
const Detail = require('../../models/Detail');


//GO TO EDIT
router.get('/edit/:id', (req, res) => {

    Progress.findOne({_id: req.params.id}).then(progress => {
        Detail.find({}).then(details => {
            res.render('admin/progresses/edit', {progress: progress, details: details}); 
        });

        //res.render('admin/posts/edit', {post: post});
    }); 
});
//UPDATE BLOG
router.put('/edit/:id', (req, res) => {

    Progress.findOne({_id: req.params.id}).then(progress => {


        // blog.user = req.user.id;
        progress.calorie = req.body.calorie;
        progress.distance = req.body.distance;
        progress.carbon_red = req.body.carbon_red;
        progress.coins = req.body.coins;
        progress.detail = req.body.detail;

        progress.save().then(updatedProgress=> {

            req.flash('success_message', `Progress was successfully updated`);
            res.redirect('/admin/progresses');
        });
    });   
});
//READ DATA
router.get('/', (req, res) => {

    Progress.find({})
    .populate('detail')
    .then(progresses => {

        res.render('admin/progresses', {progresses: progresses});
    });  
});

router.get('/create', (req, res) => {

    Detail.find({}).then(details => {
        res.render('admin/progresses/create', {details: details}); 
    });
 
});


//CREATE DATA
router.post('/create', (req, res) => {

    let errors = [];
    if(!req.body.distance){

        errors.push({message: 'please add a distance'});
    }

    

    if(errors.length > 0){

        res.render('admin/progresses/create', {
            errors: errors
        })
    } else {



    const newProgress = new Progress({

        distance: req.body.distance,
        calorie: req.body.calorie,
        //coins: req.body.coins,
        detail: req.body.detail
   });
    
    newProgress.save().then(savedProgress => {

        req.flash('success_message', `Post ${savedProgress.distance} was successfully created`);

        res.redirect('/admin/progresses');
    }).catch(error => {

        console.log('couldnot save post');
    });
}
});



//DELETE DATA
router.delete('/:id', (req, res) => {

    Progress.findOne({_id: req.params.id})
    .then(progresses =>{

            progresses.remove().then(updatedBlogs => {
            req.flash('success_message', `Progress successfully deleted`);
            res.redirect('/admin/progresses');
            });
    });
});
module.exports = router;