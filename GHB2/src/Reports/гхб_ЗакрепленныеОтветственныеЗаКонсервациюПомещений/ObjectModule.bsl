
Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
	
	_ПараметрПомещения = Новый ПараметрКомпоновкиДанных("Помещения");
	_ЗначениеПараметрПомещения = РегистрыСведений.гхб_ОтветственныеЗаКонсервациюПомещений.ВернутьПомещенияДляОтбораПоКонсервацииТекущийПользователь();	
	КомпоновщикНастроек.Настройки.ПараметрыДанных.УстановитьЗначениеПараметра(_ПараметрПомещения, _ЗначениеПараметрПомещения);
	
КонецПроцедуры
