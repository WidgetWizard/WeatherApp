import 'package:flutter/material.dart';

class LightTheme {
  final _LightColor _lightColor = _LightColor();
  late ThemeData theme;

  LightTheme() {
    theme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.green,
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(fontSize: 25, color: _lightColor._textColor)),
      //kullanımı bu sekilde
      colorScheme: const ColorScheme.light(),
      buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(
        //BURDA customize ederken öncelikle "on" içerenlerden başlamayı öneriyoruz
        onPrimary: _lightColor.blueBlue,
        onSecondary: _lightColor.kingGold,
      )),
      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: Colors.green),
        fillColor: MaterialStateProperty.all(Colors.green),
      ),
      scaffoldBackgroundColor: Colors.white70.withOpacity(0.9),
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      ),
    );
  }
}

class _LightColor {
  final Color _textColor = const Color(0xFF131111ff);
  final Color _buttonColor = const Color(0xFF131111ff);
  final Color blueBlue = const Color.fromRGBO(20, 67, 210, 1);
  final Color kingGold = const Color.fromRGBO(242, 154, 2, 1);
}

///şimdi knk biz burda theme uzerinden neler ve nasıl bi renk kombinasyonları yapabiliriz bunu su sayfadan
///senin için üreten bir içerik mevcut o da "Panache" diye bi site burda sen renk koduna göre theme kodlarını
///olusturuyor ama sürümü eski olablir buna dikkat!
///bu site işte öğrenme acıısdan iyi ama ileriki düzeylerde kullanmayı tavsiye etmiyorlar!
///
/// şimdi normalde theme'yı main.dart dosyasında verebiliyorsunuz ama burda olması gereken kullanım bu sekilde degil
/// burda olması gerekn kullanım sizin bir adet theme dosyası olusturup onun içini doldurup o sekilde kullanmak daha saglıklı
/// olucaktır!
/// yien class mantıgını kullanıyoruz theme'da da

///bu classa geldigimizde önce nesne olusuturp themeData nesnesi onu kullanarak burda projemiz için theme'yi olsuturalım
/// bunu olusturduktan sonra main.dart dosyasındaki thememızı ordan alıp ister buraya cekebilirsin ister direkt kaldırıp burda
/// yeni theme'yi doldurabilirsin
///şimdi söyle bi kullanım da yapabilirsin theme üzeirnde. sen gidip textTheme: TextTheme.light şeklinde bu kısım üzerinden gidersen
/// ve atıyorum herhangi bir widgetta da theme üzerinden style atıyorsan sen burdan bir değişiklik yaptıgında bu styleleri theme üzerinden
/// veridiğin widgetların styleleri de degisicektir aklında bulunsun
/// bunun değişim örnegi packageLearnView da mevcut !!
///
/// bunları yaparken suna dikkat etmek gerekiyor müşterinin bir theme seti varsa bunları bu sekilde verebilirisn
/// ama default olarak da yine flutterin kendi theme sı mevcut
/// yine tabi biz bu theme degerlerini zeplin ile de alabiliyoruz orası o sekilde ve ona uygun theme ayarlamalarını yapıyoruz
///
/// birde şöyle birşey var hocam colorları nasıl kullanıcaz su sekilde sen proje içerisinden hiçbir şekilde colorları cagırmamalısın
/// sen burdan colorları entegre etmelisin buna dikkat
/// tamam önceden işte bi class olustur ordan color cek demiştik o o seviyedeydi artık daha ileri seviyeye geçiyoruz
///
/// naptık yukarida class olusturduk ve bu classdaki colorları burda kullanıcagım için private yaptım degişkeni ve burdan
/// temama katarıcam! buna dikkat
///
/// peki nasıl kullanıcam o da su sekilde:şimdi run time da ikisi de aynı anda initialize edildiği için bunda sıkıntı cıkıyor bu yuzden su sekilde
/// bir yazım mevcuttur! sen gidersin bu theme değişkenine late eklersin ve Theme classının constructerinde bu degişkene degerini atarsın o zaman
/// işte bu private class olan Text classındaki coloru entegre edebilirsin
///
/// burda su sekilde bi hata karşına cıkabilir sen bu theme classındaki theme adlı değişkeni final yapmadın cunku sürekli olarak değiştiginde
/// otomatikman burdaki deger kendini yenilicektir ve colorun rengini kendin de görebilirsin ama final yaparsan bu degişkeni
/// ne kadar yenilersen yenile göremiceksin işte bu yuzden tasarımı yaparken final ypamana gerek yok ama ypatıktan sonra muhakkak final yap!
///
/// gelelim diger bir noktaya burda sen customize ediyorsan bir theme özelliğini onu baştan aşşagıya kendin şekillendirmelisin
/// burda diger bir kısım ise sudur sen theme'nı ayarlarken hangi themeyı hangi widget ilgilendiriyosa onu ona göre özelleştirmelisin düzenlemelisin
/// colorScheme ile colorları düzenleyebilirsin ama button rengini buttonTheme ile özelleştirmen gerekiyor burda dikkat etmen lazım
///
/// şimdi ufak bi tricki point verelim bu colorları isimlendiriken butonmus textmis bu tarz isimlendirmeler ile işin içinden cıkamazsınız bunu içinden cıkabilmeniz için
/// color generator name diye googleye yazın ve ordan rahatlıkla colora göre isimler verilicektir!
/// burda hex ve rgb kodları vardır isime göre burda ister hex ister rgb kodunu vericeksin burda isime göre ona göre entegre ediceksin
/// isimlendirmede kolaylık sağlıyacaktır sana!
///
/// peki bunları yapmanın avantajı nedir?
/// burdan ben artık işte default olarak rengini belirledik ama olurda bu rengi değiştirmem gerektiginde
/// ben bu renkleri theme üzerinden okumaya baslıyacagım ve bu bana theme üzerinden okudugum için generic olarak bu destegi saglamıs olucaz
/// yarın birgün bize birşey geldiğinde theme üzerinden rahatlıkla düzeni de saglamıs olucaz!
/// package_learn_view ekranında floatActionButtonı theme üzerinden rengini değiştirelim
///
/// yani bi comapnentin rengini değiştiirceksek bunları burda bu sekilde herşeyin teması var burdan özelleştirebiliyorsunuz
/// burdan bi theme_learn_view.dart dosyasına gidelim
///
/// yine burda scafoldun da themesını ayarlayabiliriz withOpacity ile
///
/// bunların hepsini işte kullandıkca alısıcaz ve anlıcaz!
