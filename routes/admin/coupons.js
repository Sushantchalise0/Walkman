const express = require('express');
const router = express.Router();
const Coupon = require('../../models/Coupon');
const Detail = require('../../models/Detail');
const Sponser = require('../../models/Sponsers');
const Product = require('../../models/Products');
const Vendor = require('../../models/Vendors');



//READ DATA
router.get('/', (req, res) => {

    Coupon.find({}).sort({created_date:-1})
    .populate('detail')
    .populate('productID')
    .populate('vendorID')
    .then(coupons => {
        Vendor.find({})
        .then(vendors => {
        res.render('admin/coupons', {coupons: coupons,vendors:vendors});
    });  
}); 
});


//CREATE 
router.get('/create', (req, res) => {

    Detail.find({})
    .then(details => {
        Product.find({})
        .then(products => {
            Vendor.find({})
            .then(vendors => {
        res.render('admin/coupons/create', {details: details, products: products,vendors:vendors}); 
        });
    });
    });
 
});


//CREATE DATA
router.post('/create', (req, res) => {

    let errors = [];
    if(!req.body.qrKey){

        errors.push({message: 'please add a qr'});
    }

    

    if(errors.length > 0){

        res.render('admin/coupons/create', {
            errors: errors
        })
    } else {

        let v_status = "true";

        if(req.body.v_status){
            v_status = "true";
        } else {
            v_status = "false";
        }

    const newCoupon = new Coupon({
        
        detail: req.body.detail,
        productID: req.body.productID,
        vendorID: req.body.vendorID,
        qrKey: req.body.qrKey,
        v_status: v_status
   });
   
    newCoupon.save().then(savedCoupon => {

        req.flash('success_message', `Post ${savedCoupon.detail} was successfully created`);

        res.redirect('/admin/coupons');
    }).catch(error => {

        console.log('couldnot save post');
    });
}
});

//DELETE DATA
router.delete('/:id', (req, res) => {

    Coupon.findOne({_id: req.params.id})
    .then(coupons =>{

            coupons.remove().then(updatedBlogs => {
            req.flash('success_message', `Coupon successfully deleted`);
            res.redirect('/admin/coupons');
            });
    });
});

//GO TO EDIT
router.get('/edit/:id', (req, res) => {

    Featured.findOne({_id: req.params.id}).then(featured => {
            res.render('admin/featured/edit', {featured: featured}); 
}); 
});

 //UPDATE DATA
 router.put('/edit/:id', (req, res) => {

    Featured.findOne({_id: req.params.id}).then(featured => {
        featured.url = req.body.url;
        featured.name=req.body.name;
        

        if(!isEmpty(req.files)){

            let file = req.files.img;
            filename = +Date.now() + '-'  + file.name;
            featured.img = '/uploads/featured/' + filename;
        
            file.mv('./public/uploads/featured/' + filename, (err) => {
        
                if (err) throw err;
            });
            }

            featured.save().then(updatedFeatured => {

            req.flash('success_message', `Featured was successfully updated`);
            res.redirect('/admin/featured');
        });
    });   
});

module.exports = router;