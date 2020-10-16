const express = require('express');
const router = express.Router();
const Statement = require('../../models/Statements');
const Product = require('../../models/Products');
const Vendor = require('../../models/Vendors');
const { isEmpty, uploadDir } = require('../../helpers/upload-helper');
const fs = require('fs');
const path = require('path');
const {userAuth} = require('../../helpers/authen');




//READ DATA
router.get('/', (req, res) => {
    Statement.find({})
    .populate("vendor_id")
    .populate("product_id")
    .then(statements => {
        res.render('admin/statements', {statements: statements});
    });  
});


//CREATE DATA
router.get('/create', (req, res) => {
    Statement.find({})
   
    .then(statements => {
        Product.find({})
        .then(products => {
            Vendor.find({})
            .then(vendors => {
        res.render('admin/statements/create', {statements: statements, products: products,vendors:vendors}); 
        });
    });
    });

});

router.post('/create', (req, res) => {
    const newStatements = new Statement({

        vendor_id: req.body.vendor_id,
        product_id: req.body.product_id,
        redeemedDate: req.body.redeemedDate,
        redeemedTime: req.body.redeemedTime,
        due: req.body.due
   });

   newStatements.save().then(savednewStatements => {
    req.flash('success_message', `New Statement was successfully created`);

        res.redirect('/admin/statements');
    }).catch(error => {

        console.log('couldnot save post');
    });

});


//DELETE DATA
router.delete('/:id', (req, res) => {

    Statement.findOne({_id: req.params.id})
    .then(statement =>{

        statement.remove().then(statementRemoved => {

                req.flash('success_message', `Statement was successfully deleted`);
                res.redirect('/admin/statements');

        });
    });
});

//GO TO EDIT
router.get('/edit/:id', (req, res) => {

    Statement.findOne({_id: req.params.id}).then(statements => {
        Vendor.find({}).then(vendors => {
            Product.find({}).then(products => {
            res.render('admin/products/edit', {statements:statements, vendors: vendors,products: products}); 
       

        //res.render('admin/posts/edit', {post: post});
              }); 
         }); 
    }); 
});


 //UPDATE DATA
 router.put('/edit/:id', (req, res) => {

    Statement.findOne({_id: req.params.id}).then(statements => {
        statements.vendor_id = req.body.vendor_id;
        statements.product_id = req.body.product_id;
        statements.redeemedDate = req.body.redeemedDate;
        statements.redeemedTime = req.body.redeemedTime;
        statements.totalDue = req.body.totalDue;

        statements.save().then(updatedStatement => {

            req.flash('success_message', `Statement was successfully updated`);
            res.redirect('/admin/statements');
        });
    });   
});

module.exports = router;