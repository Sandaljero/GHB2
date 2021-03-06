
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если РольДоступна(Метаданные.Роли.ПолныеПрава) Тогда
		_Массив = Справочники.гхб_Помещения.ВернутьАктивныеПомещенияПоТипу(Справочники.гхб_ТипыПомещений.Локация);
	Иначе
		_ФЛ = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыСеанса.ТекущийПользователь, "ФизическоеЛицо");
		
		_Массив = РегистрыСведений.гхб_ОтветственныеЗаЛокации.ВернутьЛокацииПоОтветственному(_ФЛ);
		_МассивДополнительный = РегистрыСведений.гхб_ДополнительныеОтветственныеЗаЛокации.ВернутьЛокацииПоДополнительномуОтветственному(_ФЛ);
		
		Для Каждого _Локация Из _МассивДополнительный Цикл
			Если (_Массив.Найти(_Локация) = Неопределено) Тогда
				_Массив.Добавить(_Локация);
			КонецЕсли;
		КонецЦикла;
		
		_МассивРуководители = РегистрыСведений.гхб_РуководителиЛокаций.ВернутьЛокацииПоРуководителю(_ФЛ);
		
		Для Каждого _Локация Из _МассивРуководители Цикл
			Если (_Массив.Найти(_Локация) = Неопределено) Тогда
				_Массив.Добавить(_Локация);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	СписокЛокацийДляВыбора.ЗагрузитьЗначения(_Массив);
	
	ПараметрПомещения = Новый ПараметрВыбора("ФильтрПоПомещениям", _Массив);
	ПараметрКонсервация = Новый ПараметрВыбора("КонсервацияПомещений", Истина);
	
	НовыйМассив = Новый Массив();
	НовыйМассив.Добавить(ПараметрПомещения);
	НовыйМассив.Добавить(ПараметрКонсервация);
	НовыеПараметры = Новый ФиксированныйМассив(НовыйМассив);
	
	Элементы.ПомещенияПомещение.ПараметрыВыбора = НовыеПараметры;
	
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
Процедура ПомещенияЗакрытьПриИзменении(Элемент)
	
	_ТекущиеДанные = Элементы.Помещения.ТекущиеДанные;
	
	Если НЕ (_ТекущиеДанные = Неопределено) И _ТекущиеДанные.Закрыть И НЕ _ТекущиеДанные.СуществующийДоступ Тогда
		
		_ТекущиеДанные.Закрыть = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеПоЗначению(_Значение)
	
	Если (Объект.Помещения.Количество() = 0) Тогда
		
		ЗагрузитьАктуальныеПомещения(_Значение);
		
	Иначе
		
		_ДополнительныеПараметры = Новый Структура();
		_ДополнительныеПараметры.Вставить("_Значение", _Значение);
		
		_ОписаниеОповещения = Новый ОписаниеОповещения("ВопросОчиститьПомещенияЗавершение", ЭтотОбъект, _ДополнительныеПараметры);
		
		_ТекстВопроса = НСтр("ru='Список не пустой." + Символы.ПС + "Очистить перед заполнением?';" + 
			"uk='Перелік заповнений." + Символы.ПС + "Видалити існуючі данні перед заповненням?'");
		
		_ТекстЗаголовок = НСтр("ru='Очистить помещения?';uk='Очистити приміщення?'");
		
		ПоказатьВопрос(_ОписаниеОповещения, _ТекстВопроса, РежимДиалогаВопрос.ДаНетОтмена, 60, КодВозвратаДиалога.Отмена, _ТекстЗаголовок);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВопросОчиститьПомещенияЗавершение(Ответ, ДополнительныеПараметры) Экспорт 
	
	Если (Ответ = КодВозвратаДиалога.Да) Тогда 
		Объект.Помещения.Очистить();
	ИначеЕсли (Ответ = КодВозвратаДиалога.Отмена) Тогда 
		Возврат;
	КонецЕсли;
	
	ЗагрузитьАктуальныеПомещения(ДополнительныеПараметры._Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьАктуальныеПомещения(_Значение)
	
	_СтруктураПоиска = Новый Структура("Помещение, ОтветственныйЗаКонсервациюПомещения", 
		ПредопределенноеЗначение("Справочник.гхб_Помещения.ПустаяСсылка"), 
		ПредопределенноеЗначение("Справочник.гхб_ФизическиеЛица.ПустаяСсылка"));
	
	Если ТипЗнч(_Значение) = Тип("СправочникСсылка.гхб_ФизическиеЛица") Тогда
		_МассивПомещений = ВернутьАктуальныеПомещенияДляОтветственного(_Значение, СписокЛокацийДляВыбора);
		
		Для Каждого _Помещение Из _МассивПомещений Цикл
			
			_СтруктураПоиска.Помещение = _Помещение;
			_СтруктураПоиска.ОтветственныйЗаКонсервациюПомещения = _Значение;
			_НайденныеСтроки = Объект.Помещения.НайтиСтроки(_СтруктураПоиска);
			
			Если _НайденныеСтроки.Количество() = 0 Тогда
				
				НС = Объект.Помещения.Добавить();
				НС.Помещение = _Помещение;
				НС.ОтветственныйЗаКонсервациюПомещения = _Значение;
				НС.СуществующийДоступ = Истина;
				
			КонецЕсли;
			
		КонецЦикла;
	Иначе
		_МассивОтветственных = ВернутьАктуальныеОтветственныхДляПомещения(_Значение);
		
		Для Каждого _ФизЛицо Из _МассивОтветственных Цикл
			
			_СтруктураПоиска.Помещение = _Значение;
			_СтруктураПоиска.ОтветственныйЗаКонсервациюПомещения = _ФизЛицо;
			_НайденныеСтроки = Объект.Помещения.НайтиСтроки(_СтруктураПоиска);
			
			Если _НайденныеСтроки.Количество() = 0 Тогда
				
				НС = Объект.Помещения.Добавить();
				НС.Помещение = _Значение;
				НС.ОтветственныйЗаКонсервациюПомещения = _ФизЛицо;
				НС.СуществующийДоступ = Истина;
				
			КонецЕсли;
			
		КонецЦикла;
	КонецЕсли;
		
	Объект.Помещения.Сортировать("СуществующийДоступ УБЫВ, Помещение ВОЗР, ОтветственныйЗаКонсервациюПомещения ВОЗР");
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВернутьАктуальныеПомещенияДляОтветственного(_ФизЛицо, _СписокЛокаций)
	
	Возврат РегистрыСведений.гхб_ОтветственныеЗаКонсервациюПомещений.ВернутьАктуальныеПомещенияДляОтветственногоЗаКонсервацию(_ФизЛицо, _СписокЛокаций);
	
КонецФункции

&НаСервереБезКонтекста
Функция ВернутьАктуальныеОтветственныхДляПомещения(_Помещение)
	
	Возврат РегистрыСведений.гхб_ОтветственныеЗаКонсервациюПомещений.ВернутьОтветственныхЗаКонсервациюПомещения(_Помещение);
	
КонецФункции

&НаКлиенте
Процедура ПомещенияПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
	
		ТД = Элементы.Помещения.ТекущиеДанные;
		ТД.СуществующийДоступ = Ложь;
		ТД.Закрыть = Ложь;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоУказанномуОтветственному(Команда)
	
	_ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьПоУказанномуОтветственномуЗавершение", ЭтотОбъект);
	
	_Параметры = Новый Структура();
	_Параметры.Вставить("ЭтоГруппа", Ложь);
	_Параметры.Вставить("ПометкаУдаления", Ложь);
	_Параметры.Вставить("МножественныйВыбор", Ложь);
	_Параметры.Вставить("ЗакрыватьПриВыборе", Истина);
	
	ОткрытьФорму("Справочник.гхб_ФизическиеЛица.ФормаВыбора", _Параметры, ЭтотОбъект, , , , _ОписаниеОповещения, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоУказанномуОтветственномуЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт 
	
	Если НЕ (ВыбранноеЗначение = Неопределено) Тогда 
		ЗаполнитьДанныеПоЗначению(ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПомещенияПомещениеПриИзменении(Элемент)
	
	УстановитьСуществующийПоТекущейСтроке(); 
	
КонецПроцедуры

&НаКлиенте
Процедура ПомещенияОтветственныйЗаКонсервациюПомещенияПриИзменении(Элемент)
	
	УстановитьСуществующийПоТекущейСтроке();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСуществующийПоТекущейСтроке()
	
	_ТекущиеДанные = Элементы.Помещения.ТекущиеДанные;
	
	Если НЕ (_ТекущиеДанные = Неопределено) Тогда
		
		_ТекущиеДанные.СуществующийДоступ = ВернутьПризнакСуществующийДоступ(_ТекущиеДанные.Помещение, _ТекущиеДанные.ОтветственныйЗаКонсервациюПомещения);
		
		Если НЕ _ТекущиеДанные.СуществующийДоступ И _ТекущиеДанные.Закрыть Тогда
			_ТекущиеДанные.Закрыть = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ВернутьПризнакСуществующийДоступ(_Помещение, _ОтветственныйЗаКонсервациюПомещения)
	
	Если ЗначениеЗаполнено(_Помещение) И ЗначениеЗаполнено(_ОтветственныйЗаКонсервациюПомещения) Тогда
		
		Возврат РегистрыСведений.гхб_ОтветственныеЗаКонсервациюПомещений.ПроверитьЗакреплениеОтветственногоЗаПомещением(_Помещение, _ОтветственныйЗаКонсервациюПомещения);
		
	Иначе
		
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьПоУказанномуПомещению(Команда)
	
	_ОписаниеОповещения = Новый ОписаниеОповещения("ЗаполнитьПоУказанномуПомещениюЗавершение", ЭтотОбъект);
	
	_Параметры = Новый Структура();
	_Параметры.Вставить("ЭтоГруппа", Ложь);
	_Параметры.Вставить("ПометкаУдаления", Ложь);
	_Параметры.Вставить("МножественныйВыбор", Ложь);
	_Параметры.Вставить("ЗакрыватьПриВыборе", Истина);
	_Параметры.Вставить("ФильтрПоПомещениям", СписокЛокацийДляВыбора.ВыгрузитьЗначения());
	
	ОткрытьФорму("Справочник.гхб_Помещения.ФормаВыбора", _Параметры, ЭтотОбъект, , , , _ОписаниеОповещения, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоУказанномуПомещениюЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт 
	
	Если НЕ (ВыбранноеЗначение = Неопределено) Тогда 
		ЗаполнитьДанныеПоЗначению(ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры
