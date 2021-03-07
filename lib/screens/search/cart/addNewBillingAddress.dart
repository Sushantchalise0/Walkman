import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:WalkmanMobile/services/billingAddress.dart';
import 'package:WalkmanMobile/util/colors.dart';

class AddNewBillingAddress extends StatefulWidget {
  @override
  _AddNewBillingAddressState createState() => _AddNewBillingAddressState();
}

class _AddNewBillingAddressState extends State<AddNewBillingAddress> {
  final FocusNode _nameFocus = FocusNode();

  final FocusNode _phoneNumberFocus = FocusNode();

  final FocusNode _provinceFocus = FocusNode();

  final FocusNode _cityFocus = FocusNode();

  final FocusNode _addressFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _provinceController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _apiCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('ADD NEW BILLING ADDRESS'),
        elevation: 0,
        backgroundColor: ThemeColor.darkGreen,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                cursorColor: ThemeColor.darkGreen,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Full Name'),
                validator: (value) {
                  if (value.length == 0) {
                    return 'Full Name Required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                focusNode: _phoneNumberFocus,
                cursorColor: ThemeColor.darkGreen,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                ],
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero, hintText: 'Phone Number'),
                validator: (value) {
                  if (value.length == 0) {
                    return 'Phone Number Required';
                  }
                  if (value.length != 10) {
                    return 'Phone Number should be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _provinceController,
                focusNode: _provinceFocus,
                cursorColor: ThemeColor.darkGreen,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Province'),
                validator: (value) {
                  if (value.length == 0) {
                    return 'province Field is Required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                focusNode: _cityFocus,
                cursorColor: ThemeColor.darkGreen,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'City'),
                validator: (value) {
                  if (value.length == 0) {
                    return 'City Field is Required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                focusNode: _addressFocus,
                cursorColor: ThemeColor.darkGreen,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Address'),
                validator: (value) {
                  if (value.length == 0) {
                    return 'Address Field is Required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomSheet: _apiCall == true
          ? Container(
              height: 50,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(ThemeColor.darkGreen)))
          : Container(
              height: 50,
              alignment: Alignment.center,
              child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: ThemeColor.darkGreen,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _apiCall = true;
                      });
                      final billingProvider =
                          Provider.of<BillingAddressProvider>(context);
                      billingProvider
                          .setBillingAddress(
                            '',
                              _nameController.text.trim(),
                              _phoneNumberController.text.trim(),
                              _provinceController.text.trim(),
                              _cityController.text.trim(),
                              _addressController.text.trim())
                          .then((value) {
                        setState(() {
                          _apiCall = false;
                        });
                        if (value == true) {
                          Toast.show('Your Billing Address is Saved', context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_LONG);
                        } else {
                          Toast.show('Error Saving Billing Address', context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_LONG);
                        }
                      });
                    }
                  },
                  child: Text(
                    'Add New Address',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            ),
    );
  }
}
