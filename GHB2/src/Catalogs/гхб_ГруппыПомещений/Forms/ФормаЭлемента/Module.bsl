
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СоставГруппы.Параметры.УстановитьЗначениеПараметра("ГруппаПомещений", Объект.Ссылка);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьГруппуПомещений(Команда)
	
	_Параметры = Новый Структура();
	_Параметры.Вставить("ГруппаПомещений", Объект.Ссылка);
	
	_ОписаниеОповещения = Новый ОписаниеОповещения("РедактироватьГруппуПомещенийЗавершение", ЭтотОбъект);
	
	ОткрытьФорму("Документ.гхб_ГруппыПомещений.Форма.ФормаДокумента", _Параметры, ЭтотОбъект, , , , _ОписаниеОповещения, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьГруппуПомещенийЗавершение(РезультатЗакрытия, ДополнительныеПараметры) Экспорт 
	
	Элементы.СоставГруппы.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура СоставГруппыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
КонецПроцедуры
