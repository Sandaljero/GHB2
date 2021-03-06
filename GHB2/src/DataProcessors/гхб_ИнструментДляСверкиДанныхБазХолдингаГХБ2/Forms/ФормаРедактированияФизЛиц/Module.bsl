
#Область ДействияФормыЭлементовФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	таб.Наименование КАК Наименование,
	|	таб.ИНН КАК ИНН,
	|	таб.ПометкаУдаления КАК ПометкаУдаления,
	|	таб.guid КАК guid,
	|	таб.ДоменноеИмя КАК ДоменноеИмя,
	|	таб.Пол КАК Пол,
	|	таб.ДатаРождения КАК ДатаРождения
	|ПОМЕСТИТЬ втДанные
	|ИЗ
	|	&таб КАК таб
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	втДанные.Наименование КАК Наименование,
	|	втДанные.ИНН КАК ИНН,
	|	втДанные.guid КАК guid,
	|	втДанные.ПометкаУдаления КАК ПометкаУдаления,
	|	гхб_ФизическиеЛицаБазХолдинга.Ссылка КАК ФизЛицо,
	|	втДанные.ДоменноеИмя КАК ДоменноеИмя,
	|	втДанные.Пол КАК Пол,
	|	втДанные.ДатаРождения КАК ДатаРождения
	|ИЗ
	|	втДанные КАК втДанные
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.гхб_ФизическиеЛицаБазХолдинга КАК гхб_ФизическиеЛицаБазХолдинга
	|		ПО втДанные.guid = гхб_ФизическиеЛицаБазХолдинга.GUIDБазыХолдинга
	|			И (гхб_ФизическиеЛицаБазХолдинга.БазаХолдинга = &БазаХолдинга)
	|ГДЕ
	|	(втДанные.Наименование <> гхб_ФизическиеЛицаБазХолдинга.Наименование
	|			ИЛИ втДанные.ПометкаУдаления <> гхб_ФизическиеЛицаБазХолдинга.ПометкаУдаления
	|			ИЛИ втДанные.ИНН <> гхб_ФизическиеЛицаБазХолдинга.ИНН
	|			ИЛИ втДанные.ДоменноеИмя <> гхб_ФизическиеЛицаБазХолдинга.ДоменноеИмя
	|			ИЛИ втДанные.ДатаРождения <> гхб_ФизическиеЛицаБазХолдинга.ДатаРождения
	|			ИЛИ втДанные.Пол <> гхб_ФизическиеЛицаБазХолдинга.Пол)
	|
	|СГРУППИРОВАТЬ ПО
	|	втДанные.Пол,
	|	втДанные.ДатаРождения,
	|	гхб_ФизическиеЛицаБазХолдинга.Ссылка,
	|	втДанные.guid,
	|	втДанные.ДоменноеИмя,
	|	втДанные.Наименование,
	|	втДанные.ПометкаУдаления,
	|	втДанные.ИНН";
	
	Запрос.УстановитьПараметр("таб", Параметры.тзДанные);
	Запрос.УстановитьПараметр("БазаХолдинга", Параметры.БазаХолдинга);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		новСтр = Данные.Добавить();
		ЗаполнитьЗначенияСвойств(новСтр, Выборка);
		
		Отличия = "";
		
		Если Выборка.Наименование <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "Наименование") Тогда
			Отличия = Отличия + "Наименование" + Символы.ПС;
		КонецЕсли;
		Если Выборка.ПометкаУдаления <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "ПометкаУдаления") Тогда
			Отличия = Отличия + "Пометка удаления" + Символы.ПС;
		КонецЕсли;
		Если Выборка.ИНН <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "ИНН") Тогда
			Отличия = Отличия + "ИНН" + Символы.ПС;
		КонецЕсли;
		Если Выборка.ДоменноеИмя <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "ДоменноеИмя") Тогда
			Отличия = Отличия + "Доменное имя" + Символы.ПС;
		КонецЕсли;
		Если Выборка.ДатаРождения <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "ДатаРождения") Тогда
			Отличия = Отличия + "Дата рождения" + Символы.ПС;
		КонецЕсли;
		Если Выборка.Пол <> ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Выборка.ФизЛицо, "Пол") Тогда
			Отличия = Отличия + "Пол" + Символы.ПС;
		КонецЕсли;
		
		новСтр.Отличия = СокрЛП(Отличия);
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ДанныеПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
КонецПроцедуры

#КонецОбласти

#Область Команды

&НаКлиенте
Процедура УстановитьФлаги(Команда)
	
	Для каждого СтрокаДанные Из Данные Цикл
		СтрокаДанные.ДН = Истина;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьФлаги(Команда)
	
	Для каждого СтрокаДанные Из Данные Цикл
		СтрокаДанные.ДН = Ложь;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьДанные(Команда)
	РедактироватьДанныеНаСервере();
КонецПроцедуры

&НаСервере
Процедура РедактироватьДанныеНаСервере()
	
	мНайденное = Данные.НайтиСтроки(Новый Структура("ДН", Истина));
	
	Для каждого СтрокаДанные Из мНайденное Цикл
	
		Если СтрокаДанные.Редактировано Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаДанные.Редактировано = РедактироватьФизЛицоБазыХолдинга(СтрокаДанные);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область Прочее

&НаСервере
Функция РедактироватьФизЛицоБазыХолдинга(СтрокаДанные)

	Попытка
		
		спрОбъект = СтрокаДанные.ФизЛицо.ПолучитьОбъект();
		спрОбъект.ДополнительныеСвойства.Вставить("ПометкаПришлаОбменом", Истина);
		Если спрОбъект.ИНН <> СтрокаДанные.ИНН Тогда
			
			спрОбъект.ФизЛицоТекущейБазы = ПолучитьФизЛицоТекущейБазы(СтрокаДанные.ИНН);
			спрОбъект.ИНН = СтрокаДанные.ИНН;
			
		КонецЕсли;
		
		Если спрОбъект.Наименование <> СтрокаДанные.Наименование Тогда
			спрОбъект.Наименование = СтрокаДанные.Наименование;
		КонецЕсли;
		
		Если спрОбъект.ПометкаУдаления <> СтрокаДанные.ПометкаУдаления Тогда
			спрОбъект.ПометкаУдаления = СтрокаДанные.ПометкаУдаления;
		КонецЕсли;
		
		Если спрОбъект.ДоменноеИмя <> СтрокаДанные.ДоменноеИмя Тогда
			спрОбъект.ДоменноеИмя = СтрокаДанные.ДоменноеИмя;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаДанные.Пол) И спрОбъект.Пол <> СтрокаДанные.Пол Тогда
			спрОбъект.Пол = СтрокаДанные.Пол;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаДанные.ДатаРождения) И спрОбъект.ДатаРождения <> СтрокаДанные.ДатаРождения Тогда
			спрОбъект.ДатаРождения = СтрокаДанные.ДатаРождения;
		КонецЕсли;
		
		спрОбъект.Записать();
		ОбщегоНазначения.СообщитьПользователю("Редактировано " + спрОбъект.Ссылка);
		Возврат Истина;
		
	Исключение
		
		ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());
		Возврат Ложь;
		
	КонецПопытки;

КонецФункции // РедактироватьФизЛицоБазыХолдинга()

&НаСервере
Функция ПолучитьФизЛицоТекущейБазы(ИНН)

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	гхб_ФизическиеЛица.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.гхб_ФизическиеЛица КАК гхб_ФизическиеЛица
	|ГДЕ
	|	НЕ гхб_ФизическиеЛица.ЭтоГруппа
	|	И НЕ гхб_ФизическиеЛица.ПометкаУдаления
	|	И гхб_ФизическиеЛица.ИНН = &ИНН";
	
	Запрос.УстановитьПараметр("ИНН", ИНН);
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка;
	Иначе
		Возврат Неопределено;
	КонецЕсли;

КонецФункции // ПолучитьФизЛицоТекущейБазы()

#КонецОбласти


