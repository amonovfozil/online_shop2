import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:online_shop/models/products.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool status = false;
  Color pickerColor = Colors.white;
  Color CurrentColor = Colors.white;
  final _imageFormId = GlobalKey<FormState>();
  final _TextFormId = GlobalKey<FormState>();
  var hasImage = true;
  product _product = product(
    id: '',
    title: '',
    image: '',
    info: '',
    price: 0,
    backgarund: Colors.white,
  );

  var init = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (init) {
      final productid = ModalRoute.of(context)!.settings.arguments;
      if (productid != null) {
        final _EditingProduct =
            Provider.of<productIteam>(context, listen: false)
                .list
                .firstWhere((product) => product.id == productid);

        _product = _EditingProduct;
      }
      print(_product.id);
    }
    init = false;
  }

  @override
  Widget build(BuildContext context) {
    final productIteams = Provider.of<productIteam>(context);
    void SaveImgeForm() {
      _imageFormId.currentState!.validate();
      var checkImage = _imageFormId.currentState!.validate();
      if (checkImage) {
        _imageFormId.currentState!.save();
        print(_product.image);
        Navigator.of(context).pop();
      }
    }

    void SaveTextForm() {
      _TextFormId.currentState!.validate();
      var checktext = _TextFormId.currentState!.validate();
      setState(() {
        hasImage = _product.image.isNotEmpty;
      });
      if (checktext && hasImage) {
        _TextFormId.currentState!.save();
        if (_product.id.isEmpty) {
          productIteams.AddNewproduct(
            _product.title,
            _product.info,
            _product.image,
            _product.price,
            _product.discount,
            CurrentColor,
            status,
          );
        } else {
          productIteams.UpdateProduct(_product);
        }

        Navigator.of(context).pop();
      }
    }

    void EnterImageUrl() {
      showDialog(
          context: context,
          builder: ((context) {
            return Form(
              key: _imageFormId,
              child: AlertDialog(
                title: Text(
                  "Rasm manzilini kiriting",
                ),
                content: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'URL:',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _product.image,
                  onSaved: (newValue) {
                    setState(() {
                      _product = product(
                        id: _product.id,
                        title: _product.title,
                        image: newValue!,
                        info: _product.info,
                        price: _product.price,
                        backgarund: _product.backgarund,
                      );
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos rasm manzilini kiriting';
                    } else if (!value.startsWith('https:/')) {
                      return 'https:/ network image manzilini kiriting';
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'cencel',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).errorColor),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: SaveImgeForm,
                    child: Text(
                      'Enter',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        backgroundColor: Colors.teal.shade800),
                  ),
                ],
              ),
            );
          }));
    }

    void changecolors() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text("Rang tanlang!")),
            content: BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color) {
                setState(() {
                  pickerColor = Color;
                });
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'cencel',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).errorColor),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    print(CurrentColor);
                    CurrentColor = pickerColor;
                    print(CurrentColor);
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'Enter',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    backgroundColor: Colors.teal.shade800),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceEvenly,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Yangi Mahsulot'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: SaveTextForm,
            icon: Icon(Icons.save_as_outlined),
          ),
        ],
      ),
      body: Form(
        key: _TextFormId,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nomi:',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _product.title,
                  onSaved: (newValue) {
                    _product = product(
                        id: _product.id,
                        title: newValue!,
                        image: _product.image,
                        info: _product.info,
                        price: _product.price,
                        backgarund: _product.backgarund);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos Mahsulot nomini kiriting';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Tarif:',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _product.info,
                    onSaved: (newValue) {
                      _product = product(
                          id: _product.id,
                          title: _product.title,
                          image: _product.image,
                          info: newValue!,
                          price: _product.price,
                          backgarund: _product.backgarund);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Iltimos Mahsulotga ta`rif bering';
                      } else if (value.length < 10) {
                        return 'Ta`rif kamida 10 so`zdan iborat bo`lsin';
                      }
                    }),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Narxi:',
                    border: OutlineInputBorder(),
                  ),
                  initialValue:
                      _product.price == 0 ? '' : _product.price.toString(),
                  onSaved: (newValue) {
                    _product = product(
                        id: _product.id,
                        title: _product.title,
                        image: _product.image,
                        info: _product.info,
                        price: double.parse(newValue!),
                        backgarund: _product.backgarund);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos Mahsulot nomini kiriting';
                    } else if (double.tryParse(value) == null) {
                      return 'Iltimos To`gri qiymat kirgizing';
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Chegirma %:',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _product.discount == 0
                      ? ''
                      : _product.discount.toString(),
                  onSaved: (newValue) {
                    _product = product(
                        id: _product.id,
                        title: _product.title,
                        image: _product.image,
                        info: _product.info,
                        price: _product.price,
                        discount: double.parse(newValue!),
                        backgarund: _product.backgarund);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos Mahsulot nomini kiriting';
                    } else if (double.tryParse(value) == null) {
                      return 'Iltimos To`gri qiymat kirgizing';
                    } else if (double.parse(value) > 100) {
                      return '100% dan kichik miqdor kiriting';
                    }
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text('Yangimi:'),
                    Checkbox(
                      side: BorderSide(),
                      activeColor: Colors.teal,
                      checkColor: Colors.white,
                      value: status,
                      onChanged: (value) {
                        setState(() {
                          status = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Orqa fon rangini tanlang:  '),
                    InkWell(
                      onTap: () => changecolors(),
                      child: Container(
                        height: 19,
                        width: 19,
                        decoration: BoxDecoration(
                          color: CurrentColor,
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Card(
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      width: 1,
                      color: hasImage ? Colors.black : Colors.red,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => EnterImageUrl(),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: _product.image != ''
                          ? _product.image.startsWith('assets/')
                              ? Image.asset(
                                  _product.image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  _product.image,
                                  fit: BoxFit.cover,
                                )
                          : Center(
                              child: Text(
                              'Rasm URLni kiriting!',
                              style: TextStyle(
                                color: hasImage ? Colors.black : Colors.red,
                              ),
                            )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
