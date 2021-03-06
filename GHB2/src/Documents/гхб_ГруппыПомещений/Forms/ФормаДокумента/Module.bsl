
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Если Параметры.Свойство("ГруппаПомещений") Тогда
			
			Объект.ГруппаПомещений = Параметры.ГруппаПомещений;
			
			_Массив = ВернутьСоставГруппыПомещений(Объект.ГруппаПомещений);
		
			Для Каждого _Структура Из _Массив Цикл
				
				НС = Объект.СоставГруппыПомещений.Добавить();
				НС.Помещение = _Структура.Помещение;
				НС.СуществующийДоступ = Истина;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВидимостьДоступность()
	
	ЭтотОбъект.ТолькоПросмотр = ДокументБылПроведен(Объект.Ссылка);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДокументБылПроведен(_Ссылка)
	
	Возврат РегистрыСведений.гхб_СобытияОбъектовБД.СобытиеПоОбъектуБыло(_Ссылка, Перечисления.гхб_ТипыСобытийОбъектовБД.ПервоеПроведениеДокумента);
	
КонецФункции

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	УстановитьВидимостьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура СоставГруппыПомещенийЗакрытьПриИзменении(Элемент)
	
	_ТекущиеДанные = Элементы.СоставГруппыПомещений.ТекущиеДанные;
	
	Если НЕ (_ТекущиеДанные = Неопределено) И _ТекущиеДанные.Закрыть И НЕ _ТекущиеДанные.СуществующийДоступ Тогда
		_ТекущиеДанные.Закрыть = Ложь;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ГруппаПомещенийПриИзменении(Элемент)
	
	ЗаполнитьДанныеПоГруппеПомещений(Объект.ГруппаПомещений);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеПоГруппеПомещений(_ГруппаПомещений)
	
	Объект.СоставГруппыПомещений.Очистить();
	
	Если ЗначениеЗаполнено(_ГруппаПомещений) Тогда
		
		_Массив = ВернутьСоставГруппыПомещений(_ГруппаПомещений);
		
		Для Каждого _Структура Из _Массив Цикл
			
			НС = Объект.СоставГруппыПомещений.Добавить();
			НС.Помещение = _Структура.Помещение;
			НС.СуществующийДоступ = Истина;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВернутьСоставГруппыПомещений(_ГруппаПомещений)
	
	Возврат РегистрыСведений.гхб_СоставГруппПомещений.ВернутьДанныеПоГруппеПомещений(_ГруппаПомещений);
	
КонецФункции

&НаКлиенте
Процедура СоставГруппыПомещенийПередУдалением(Элемент, Отказ)
	
	_ТекущиеДанные = Элементы.СоставГруппыПомещений.ТекущиеДанные;
	
	Если НЕ (_ТекущиеДанные = Неопределено) И _ТекущиеДанные.СуществующийДоступ Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставГруппыПомещенийПриАктивизацииСтроки(Элемент)
	
	_ТекущиеДанные = Элементы.СоставГруппыПомещений.ТекущиеДанные;
	
	Если НЕ (_ТекущиеДанные = Неопределено) Тогда
		Элементы.СоставГруппыПомещенийПомещение.ТолькоПросмотр = _ТекущиеДанные.СуществующийДоступ;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СоставГруппыПомещенийПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
	
		ТД = Элементы.СоставГруппыПомещений.ТекущиеДанные;
		ТД.СуществующийДоступ = Ложь;
		ТД.Закрыть = Ложь;

	КонецЕсли;
	
КонецПроцедуры
