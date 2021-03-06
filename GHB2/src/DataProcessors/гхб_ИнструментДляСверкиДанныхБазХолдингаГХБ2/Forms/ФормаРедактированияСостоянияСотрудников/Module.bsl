
#Область СобытияФормыЭлементовФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	БазаХолдингаСсылка = Параметры.БазаХолдинга;
	ЗаполнитьДанные();
	
КонецПроцедуры

&НаКлиенте
Процедура ДанныеНовыеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДанныеНовыеПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДанныеУдалениеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДанныеУдалениеПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДанныеРедактированиеПередУдалением(Элемент, Отказ)
	Отказ = Истина;
КонецПроцедуры

&НаКлиенте
Процедура ДанныеРедактированиеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура УстановитьФлагиНовые(Команда)
	
	Для каждого СтрокаДанные Из ДанныеНовые Цикл
		СтрокаДанные.ДН = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлагиНовые(Команда)
	
	Для каждого СтрокаДанные Из ДанныеНовые Цикл
		СтрокаДанные.ДН = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлагиРедактирование(Команда)
	
	Для каждого СтрокаДанные Из ДанныеРедактирование Цикл
		СтрокаДанные.ДН = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлагиРедактирование(Команда)
	
	Для каждого СтрокаДанные Из ДанныеРедактирование Цикл
		СтрокаДанные.ДН = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьФлагиУдаление(Команда)
	
	Для каждого СтрокаДанные Из ДанныеУдаление Цикл
		СтрокаДанные.ДН = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлагиУдаление(Команда)
	
	Для каждого СтрокаДанные Из ДанныеУдаление Цикл
		СтрокаДанные.ДН = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьДанные(Команда)
	РедактироватьДанныеСервер();
КонецПроцедуры

&НаСервере
Процедура РедактироватьДанныеСервер()

	мНайденное = ДанныеРедактирование.НайтиСтроки(Новый Структура("ДН", Истина));
	
	Для каждого СтрокаДанные Из мНайденное Цикл
	
		Если СтрокаДанные.Обработано Тогда 
			Продолжить;
		КонецЕсли;
		
		Набор = РегистрыСведений.гхб_СостояниеРаботниковОрганизаций.СоздатьНаборЗаписей();
		Набор.Отбор.Период.Установить(СтрокаДанные.Период);
		Набор.Отбор.БазаХолдинга.Установить(БазаХолдингаСсылка);
		Набор.Отбор.Организация.Установить(СтрокаДанные.Организация);
		Набор.Отбор.Сотрудник.Установить(СтрокаДанные.Сотрудник);
		
		Набор.Прочитать();
		ЗаписатьНабор = Ложь;
		
		Если Набор.Количество() = 1 Тогда
			
			Если Набор[0].ПериодЗавершения <> СтрокаДанные.ПериодЗавершения Тогда
				
				Набор[0].ПериодЗавершения = СтрокаДанные.ПериодЗавершения;
				ЗаписатьНабор = Истина;
				
			КонецЕсли;
			
			Если Набор[0].Состояние <> СтрокаДанные.Состояние Тогда
				
				Набор[0].Состояние = СтрокаДанные.Состояние;
				ЗаписатьНабор = Истина;
				
			КонецЕсли;
			
			Если Набор[0].СостояниеЗавершения <> СтрокаДанные.СостояниеЗавершения Тогда
				
				Набор[0].СостояниеЗавершения = СтрокаДанные.СостояниеЗавершения;
				ЗаписатьНабор = Истина;
				
			КонецЕсли;
			
			Если ЗаписатьНабор Тогда
			
				Набор.Записать();
				СтрокаДанные.Обработано = Истина;
			
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;

КонецПроцедуры // РедактироватьДанныеСервер()

&НаКлиенте
Процедура СоздатьДанные(Команда)
	СоздатьДанныеСервер();
КонецПроцедуры

&НаСервере
Процедура СоздатьДанныеСервер()

	мНайденное = ДанныеНовые.НайтиСтроки(Новый Структура("ДН", Истина));
	
	Для каждого СтрокаДанные Из мНайденное Цикл
	
		Если СтрокаДанные.Обработано Тогда
			Продолжить;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(СтрокаДанные.Период) 
			Или Не ЗначениеЗаполнено(СтрокаДанные.Организация) 
			Или Не ЗначениеЗаполнено(СтрокаДанные.Сотрудник)
			Или Не ЗначениеЗаполнено(БазаХолдингаСсылка) Тогда
			Продолжить;
		КонецЕсли;
		
		Запись = РегистрыСведений.гхб_СостояниеРаботниковОрганизаций.СоздатьМенеджерЗаписи();
		ЗаполнитьЗначенияСвойств(Запись, СтрокаДанные);
		Запись.БазаХолдинга = БазаХолдингаСсылка;
		Запись.Записать();
		СтрокаДанные.Обработано = Истина;
		
	КонецЦикла

КонецПроцедуры // СоздатьДанныеСервер()

&НаКлиенте
Процедура УдалитьДаные(Команда)
	УдалитьДаныеСервер();
КонецПроцедуры

&НаСервере
Процедура УдалитьДаныеСервер()
	
	мНайденное = ДанныеУдаление.НайтиСтроки(Новый Структура("ДН", Истина));
	
	Для каждого СтрокаДанные Из мНайденное Цикл
	
		Если СтрокаДанные.Обработано Тогда
			Продолжить;
		КонецЕсли;
		
		Набор = РегистрыСведений.гхб_СостояниеРаботниковОрганизаций.СоздатьНаборЗаписей();
		Набор.Отбор.Период.Установить(СтрокаДанные.Период);
		Набор.Отбор.БазаХолдинга.Установить(БазаХолдингаСсылка);
		Набор.Отбор.Организация.Установить(СтрокаДанные.Организация);
		Набор.Отбор.Сотрудник.Установить(СтрокаДанные.Сотрудник);
		
		Набор.Прочитать();
			
		Если Набор.Количество() = 1 Тогда
			
			Набор.Очистить();
			Попытка
				
				Набор.Записать();
				СтрокаДанные.Обработано = Истина;
				
			Исключение
				ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());
			КонецПопытки;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Процедура ЗаполнитьДанные()

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("таб", Параметры.тзДанные);
	Запрос.УстановитьПараметр("БазаХолдинга", БазаХолдингаСсылка);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Таб.Период КАК Период,
	|	Таб.Организация КАК Организация,
	|	Таб.Организацияguid КАК Организацияguid,
	|	Таб.Сотрудник КАК Сотрудник,
	|	Таб.Сотрудникguid КАК Сотрудникguid,
	|	Таб.Состояние КАК Состояние,
	|	Таб.СостояниеЗавершения КАК СостояниеЗавершения,
	|	Таб.ПериодЗавершения КАК ПериодЗавершения
	|ПОМЕСТИТЬ втДанные
	|ИЗ
	|	&Таб КАК Таб
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втДанные.Период КАК Период,
	|	втДанные.Организация КАК Организация,
	|	втДанные.Организацияguid КАК Организацияguid,
	|	втДанные.Сотрудник КАК Сотрудник,
	|	втДанные.Сотрудникguid КАК Сотрудникguid,
	|	втДанные.Состояние КАК Состояние,
	|	втДанные.СостояниеЗавершения КАК СостояниеЗавершения,
	|	втДанные.ПериодЗавершения КАК ПериодЗавершения,
	|	гхб_ОрганизацииБазХолдинга.Ссылка КАК ОрганизацияСсылка,
	|	гхб_СотрудникиБазХолдинга.Ссылка КАК СотрудникСсылка
	|ПОМЕСТИТЬ втСоСсылками
	|ИЗ
	|	втДанные КАК втДанные
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.гхб_СотрудникиБазХолдинга КАК гхб_СотрудникиБазХолдинга
	|		ПО втДанные.Сотрудникguid = гхб_СотрудникиБазХолдинга.GUIDБазыХолдинга
	|			И (гхб_СотрудникиБазХолдинга.БазаХолдинга = &БазаХолдинга)
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.гхб_ОрганизацииБазХолдинга КАК гхб_ОрганизацииБазХолдинга
	|		ПО втДанные.Организацияguid = гхб_ОрганизацииБазХолдинга.GUIDБазыХолдинга
	|			И (гхб_ОрганизацииБазХолдинга.БазаХолдинга = &БазаХолдинга)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втСоСсылками.Период КАК Период,
	|	гхб_ОрганизацииБазХолдинга.Ссылка КАК Организация,
	|	втСоСсылками.Организацияguid КАК Организацияguid,
	|	гхб_СотрудникиБазХолдинга.Ссылка КАК Сотрудник,
	|	втСоСсылками.Сотрудникguid КАК Сотрудникguid,
	|	втСоСсылками.Состояние КАК Состояние,
	|	втСоСсылками.СостояниеЗавершения КАК СостояниеЗавершения,
	|	втСоСсылками.ПериодЗавершения КАК ПериодЗавершения,
	|	гхб_СостояниеРаботниковОрганизаций.Период КАК ПериодБХ,
	|	гхб_СостояниеРаботниковОрганизаций.БазаХолдинга КАК БазаХолдингаБХ,
	|	гхб_СостояниеРаботниковОрганизаций.Организация КАК ОрганизацияБХ,
	|	гхб_СостояниеРаботниковОрганизаций.ПериодЗавершения КАК ПериодЗавершенияБХ,
	|	гхб_СостояниеРаботниковОрганизаций.Сотрудник КАК СотрудникБХ,
	|	гхб_СостояниеРаботниковОрганизаций.Состояние КАК СостояниеБХ,
	|	гхб_СостояниеРаботниковОрганизаций.СостояниеЗавершения КАК СостояниеЗавершенияБХ,
	|	""РИБ"" КАК ТипДанных,
	|	""ГХБ 2.0"" КАК ТипДанныхБХ,
	|	гхб_ОрганизацииБазХолдинга.GUIDБазыХолдинга КАК ОрганизацияguidБХ,
	|	гхб_СотрудникиБазХолдинга.GUIDБазыХолдинга КАК СотрудникguidБХ
	|ИЗ
	|	втСоСсылками КАК втСоСсылками
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.гхб_СостояниеРаботниковОрганизаций КАК гхб_СостояниеРаботниковОрганизаций
	|		ПО втСоСсылками.Период = гхб_СостояниеРаботниковОрганизаций.Период
	|			И втСоСсылками.ОрганизацияСсылка = гхб_СостояниеРаботниковОрганизаций.Организация
	|			И втСоСсылками.СотрудникСсылка = гхб_СостояниеРаботниковОрганизаций.Сотрудник
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.гхб_ОрганизацииБазХолдинга КАК гхб_ОрганизацииБазХолдинга
	|		ПО втСоСсылками.ОрганизацияСсылка = гхб_ОрганизацииБазХолдинга.Ссылка
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.гхб_СотрудникиБазХолдинга КАК гхб_СотрудникиБазХолдинга
	|		ПО втСоСсылками.СотрудникСсылка = гхб_СотрудникиБазХолдинга.Ссылка
	|ГДЕ
	|	гхб_СостояниеРаботниковОрганизаций.БазаХолдинга = &БазаХолдинга
	|	И (втСоСсылками.ПериодЗавершения <> гхб_СостояниеРаботниковОрганизаций.ПериодЗавершения
	|			ИЛИ втСоСсылками.Состояние <> гхб_СостояниеРаботниковОрганизаций.Состояние
	|			ИЛИ втСоСсылками.СостояниеЗавершения <> гхб_СостояниеРаботниковОрганизаций.СостояниеЗавершения)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втСоСсылками.Период КАК Период,
	|	гхб_ОрганизацииБазХолдинга.Ссылка КАК Организация,
	|	втСоСсылками.Организацияguid КАК Организацияguid,
	|	гхб_СотрудникиБазХолдинга.Ссылка КАК Сотрудник,
	|	втСоСсылками.Сотрудникguid КАК Сотрудникguid,
	|	втСоСсылками.Состояние КАК Состояние,
	|	втСоСсылками.СостояниеЗавершения КАК СостояниеЗавершения,
	|	""РИБ"" КАК ТипДанных,
	|	втСоСсылками.ПериодЗавершения КАК ПериодЗавершения
	|ИЗ
	|	втСоСсылками КАК втСоСсылками
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.гхб_СостояниеРаботниковОрганизаций КАК гхб_СостояниеРаботниковОрганизаций
	|		ПО втСоСсылками.Период = гхб_СостояниеРаботниковОрганизаций.Период
	|			И втСоСсылками.ОрганизацияСсылка = гхб_СостояниеРаботниковОрганизаций.Организация
	|			И втСоСсылками.СотрудникСсылка = гхб_СостояниеРаботниковОрганизаций.Сотрудник
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.гхб_СотрудникиБазХолдинга КАК гхб_СотрудникиБазХолдинга
	|		ПО втСоСсылками.СотрудникСсылка = гхб_СотрудникиБазХолдинга.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.гхб_ОрганизацииБазХолдинга КАК гхб_ОрганизацииБазХолдинга
	|		ПО втСоСсылками.ОрганизацияСсылка = гхб_ОрганизацииБазХолдинга.Ссылка
	|ГДЕ
	|	гхб_СостояниеРаботниковОрганизаций.Период ЕСТЬ NULL
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	гхб_СостояниеРаботниковОрганизаций.Период КАК Период,
	|	гхб_СостояниеРаботниковОрганизаций.Организация КАК Организация,
	|	гхб_СостояниеРаботниковОрганизаций.Сотрудник КАК Сотрудник,
	|	гхб_СостояниеРаботниковОрганизаций.Состояние КАК Состояние,
	|	гхб_СостояниеРаботниковОрганизаций.СостояниеЗавершения КАК СостояниеЗавершения,
	|	гхб_СостояниеРаботниковОрганизаций.ПериодЗавершения КАК ПериодЗавершения,
	|	гхб_ОрганизацииБазХолдинга.GUIDБазыХолдинга КАК Организацияguid,
	|	""ГХБ 2.0"" КАК ТипДанных,
	|	гхб_СотрудникиБазХолдинга.GUIDБазыХолдинга КАК Сотрудникguid
	|ИЗ
	|	РегистрСведений.гхб_СостояниеРаботниковОрганизаций КАК гхб_СостояниеРаботниковОрганизаций
	|		ЛЕВОЕ СОЕДИНЕНИЕ втСоСсылками КАК втСоСсылками
	|		ПО гхб_СостояниеРаботниковОрганизаций.Период = втСоСсылками.Период
	|			И гхб_СостояниеРаботниковОрганизаций.Организация = втСоСсылками.ОрганизацияСсылка
	|			И гхб_СостояниеРаботниковОрганизаций.Сотрудник = втСоСсылками.СотрудникСсылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.гхб_ОрганизацииБазХолдинга КАК гхб_ОрганизацииБазХолдинга
	|		ПО гхб_СостояниеРаботниковОрганизаций.Организация = гхб_ОрганизацииБазХолдинга.Ссылка
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.гхб_СотрудникиБазХолдинга КАК гхб_СотрудникиБазХолдинга
	|		ПО гхб_СостояниеРаботниковОрганизаций.Сотрудник = гхб_СотрудникиБазХолдинга.Ссылка
	|ГДЕ
	|	втСоСсылками.Период ЕСТЬ NULL
	|	И гхб_СостояниеРаботниковОрганизаций.БазаХолдинга = &БазаХолдинга";
	
	резПакет = Запрос.ВыполнитьПакет();
	
	Выборка = резПакет[2].Выбрать();
	
	Если Выборка.Количество() > 0 Тогда
		
		Пока Выборка.Следующий() Цикл
			
			Отличия = "";
			
			Если Выборка.ПериодЗавершения <> Выборка.ПериодЗавершенияБХ Тогда
				Отличия = Отличия + "Период завершения" + Символы.ПС;
			КонецЕсли;
			Если Выборка.Состояние <> Выборка.СостояниеБХ Тогда
				Отличия = Отличия + "Состояние" + Символы.ПС;
			КонецЕсли;
			Если Выборка.СостояниеЗавершения <> Выборка.СостояниеЗавершенияБХ Тогда
				Отличия = Отличия + "Состояние завершения" + Символы.ПС;
			КонецЕсли;
			
			новСтр = ДанныеРедактирование.Добавить();
			ЗаполнитьЗначенияСвойств(новСтр, Выборка);
			новСтр.Отличия = Отличия;
			
		КонецЦикла;
	
	КонецЕсли;
		
	Выборка = резПакет[3].Выбрать();
	
	Если Выборка.Количество() > 0 Тогда
		
		Пока Выборка.Следующий() Цикл
			
			новСтр = ДанныеНовые.Добавить();
			ЗаполнитьЗначенияСвойств(новСтр, Выборка);
			
		КонецЦикла;
	
	КонецЕсли;
	
	Выборка = резПакет[4].Выбрать();
	
	Если Выборка.Количество() > 0 Тогда
		
		Пока Выборка.Следующий() Цикл
			
			новСтр = ДанныеУдаление.Добавить();
			ЗаполнитьЗначенияСвойств(новСтр, Выборка);
			
		КонецЦикла;
	
	КонецЕсли;
	
КонецПроцедуры // ЗаполнитьДанныеДляСоздания()

#КонецОбласти