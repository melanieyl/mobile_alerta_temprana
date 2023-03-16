import 'package:flutter/material.dart';
import 'package:mobile_alerta_temprana/models/Evento.dart';
import 'package:mobile_alerta_temprana/pages/show_alerts/contact_list_page.dart';
import 'package:mobile_alerta_temprana/utils/responsive.dart';

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // List<Event> eventosCategories = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 5,
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Stack(
          children: [
            ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 50,
                      ),
                      itemCount: eventos.length,
                      itemBuilder: (context, index2) {
                        return Column(
                          children: [
                            RawMaterialButton(
                              onPressed: () {
                                print("holaaaaa");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MicrosListPage(
                                            nombreEvento:
                                                eventos[index2].nombre)));
                              },
                              child: Container(
                                height: 140,
                                width: 140,
                                // height: MediaQuery.of(context).size.height,
                                // width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image:
                                        AssetImage(eventos[index2].foto.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              eventos[index2].nombre,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            Positioned(
              child: Container(
                width: responsive.width,
                height: responsive.hp(13),
                color: Colors.white,
                child: Image.asset(
                  'imgs/sloganSCZ.png',
                  scale: responsive.dp(2),
                ),
              ),
            ),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: Positioned(
      //     child: Container(
      //       width: responsive.width,
      //       height: responsive.hp(11),
      //       color: Colors.white,
      //       child: Image.asset(
      //         'imgs/sloganSCZ.png',
      //         scale: responsive.dp(2),
      //       ),
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        heroTag: "MainButton",
        backgroundColor: Colors.green.shade900,
        child: Icon(Icons.call),
        onPressed: () {
          // socketService.emit('emitir-mensaje',
          //     {'nombre': 'Flutter', 'mensaje': 'Hola desde Flutter'});
          // Navigator.pushNamed(context, 'usuarios');
        },
      ),
    );
  }
}

// double heightForGalleryProducts(int index) {
//   double result = 0;
//   productsByCategory = [];

//   for (var i = 0; i < products.length; i++) {
//     if (products[i].categoria.nombre == categoriesProducts[index].name) {
//       result = result + 1;
//       productsByCategory.add(products[i]);
//     }
//   }
//   if (result % 3 != 0) {
//     result = ((result / 3).truncate() + 1) * 175;
//   } else {
//     result = (result / 3) * 175;
//   }

//   return result;
// }