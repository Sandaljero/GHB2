#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ВернутьТекущуюСтрокуПодписания(_Объект) Экспорт 
	
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	               |	ПодписаниеТаблицаПодписания.Ссылка,
	               |	ПодписаниеТаблицаПодписания.НомерСтроки КАК НомерСтроки,
	               |	ПодписаниеТаблицаПодписания.Стадия,
	               |	ПодписаниеТаблицаПодписания.ПодписаниеВсех,
	               |	ПодписаниеТаблицаПодписания.Приоритет,
	               |	ПодписаниеТаблицаПодписания.Email,
	               |	ПодписаниеТаблицаПодписания.SMS,
	               |	ПодписаниеТаблицаПодписания.Редактирование,
	               |	ПодписаниеТаблицаПодписания.СрокПодписания,
	               |	ПодписаниеТаблицаПодписания.ВидДействия,
	               |	ПодписаниеТаблицаПодписания.Получатель,
	               |	ПодписаниеТаблицаПодписания.БазовоеСобытие,
	               |	ПодписаниеТаблицаПодписания.ДатаВыдачи,
	               |	ПодписаниеТаблицаПодписания.СостояниеПодписи,
	               |	ПодписаниеТаблицаПодписания.ДатаПодписания,
	               |	ПодписаниеТаблицаПодписания.Сотрудник,
	               |	ПодписаниеТаблицаПодписания.Комментарии,
	               |	ПодписаниеТаблицаПодписания.СозданнаяЗадача,
	               |	ПодписаниеТаблицаПодписания.Подразделение,
	               |	ПодписаниеТаблицаПодписания.Должность
	               |ИЗ
	               |	БизнесПроцесс.Подписание.ТаблицаПодписания КАК ПодписаниеТаблицаПодписания
	               |ГДЕ
	               |	ПодписаниеТаблицаПодписания.СостояниеПодписи = &НаПодписании
	               |	И ПодписаниеТаблицаПодписания.Ссылка.ПодписываемыйОбъект = &ПодписываемыйОбъект
	               |	И (НЕ ПодписаниеТаблицаПодписания.Ссылка.ПометкаУдаления)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	НомерСтроки";
				   
	Запрос.УстановитьПараметр("ПодписываемыйОбъект", _Объект);
	Запрос.УстановитьПараметр("НаПодписании", Перечисления.но_СостояниеПодписи.НаПодписании);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка;
	Иначе 
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

Функция ПроверитьСсылку(СсылкаНаОбъект, ХранНастроекОтборов) Экспорт
	
	_Отчет = гхб_ДокументооборотСервер.ПолучитьОтчетДляОбъекта(СсылкаНаОбъект.Метаданные());
	
	СКД = _Отчет.СКД;
	Постр1 = _Отчет.КН;
	//Постр1 = _Отчет.КомпоновщикНастроек;
	//Постр1 = Справочники.но_МаршрутыСогласования.ПолучитьПостроительДляОбъекта(СсылкаНаОбъект.Метаданные());
	
	гхб_ДокументооборотСервер.ВосстановитьХранилищеОтборовВПостроитель(Постр1, ХранНастроекОтборов);
	
	Постр1.Настройки.ПараметрыДанных.Элементы.Найти("Ссылка").Значение = СсылкаНаОбъект;
	Постр1.Настройки.ПараметрыДанных.Элементы.Найти("Ссылка").Использование = Истина;
	
	Если гхб_СогласованиеДокументов.ЕстьРеквизитДокумента("Ответственный", СсылкаНаОбъект.Метаданные()) Тогда
		//Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ТекущаяДата").Значение = НачалоДня(ОбщегоНазначенияСервер.ТекущееВремя());
		Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ОтветственныйЗаОбъект").Значение = СсылкаНаОбъект.Ответственный;
		//Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ПричинаИзмененияСостояния").Значение = Перечисления.ПричиныИзмененияСостояния.Увольнение;
		
		//Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ТекущаяДата").Использование = Истина;
		Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ОтветственныйЗаОбъект").Использование = Истина;
		//Постр1.Настройки.ПараметрыДанных.Элементы.Найти("ПричинаИзмененияСостояния").Использование = Истина;
	КонецЕсли;
	
	_ТЗ = Новый ТаблицаЗначений();
	
	ДанныеРасшифровки = Новый ДанныеРасшифровкиКомпоновкиДанных;
    КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
     
    МакетКомпоновки = КомпоновщикМакета.Выполнить(СКД, Постр1.Настройки, ДанныеРасшифровки, , Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
     
    ПроцессорКомпоновкиДанных = Новый ПроцессорКомпоновкиДанных;
    ПроцессорКомпоновкиДанных.Инициализировать(МакетКомпоновки,,ДанныеРасшифровки, Истина);
     
    ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
     
    ПроцессорВывода.УстановитьОбъект(_ТЗ);
    ПроцессорВывода.Вывести(ПроцессорКомпоновкиДанных);	
	
	Возврат НЕ (_ТЗ.Количество() = 0);
	
КонецФункции

Функция ВернутьПредопределенныйЭлементНаОснованииДокумента(пРоль, пДокумент, ТипОтбора = Неопределено) Экспорт 
	
	Попытка
		МетаданныеОбъекта = пДокумент.Метаданные();
	Исключение
		Возврат Справочники.гхб_ФизическиеЛица.ПустаяСсылка();
	КонецПопытки;
	
	Возврат пРоль;
	
КонецФункции

Функция ВернутьСписокМаршрутовДляОбъекта(_Объект) Экспорт 
	
	_Сп = Новый СписокЗначений();
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	МаршрутыСогласования.Ссылка КАК МаршрутПодписания
	                      |ИЗ
	                      |	Справочник.но_МаршрутыСогласования КАК МаршрутыСогласования
						  |	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.но_ТипыДокументов КАК ТипыДокументов
						  |		ПО ТипыДокументов.Ссылка = МаршрутыСогласования.ТипДокумента
	                      |ГДЕ
	                      |	НЕ ТипыДокументов.ПометкаУдаления
	                      |	И НЕ МаршрутыСогласования.ПометкаУдаления
						  |	И (ТипыДокументов.ТипДокумента = &ТипДокумента1
						  |	ИЛИ ТипыДокументов.ТипДокумента = &ТипДокумента2)");
						  
	Запрос.УстановитьПараметр("ТипДокумента1", _Объект.Метаданные().Имя);
	Запрос.УстановитьПараметр("ТипДокумента2", _Объект.Метаданные().Синоним);
	_Сп.ЗагрузитьЗначения(Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("МаршрутПодписания"));
	
	Возврат _Сп;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ВернутьРольОтветственногоЗаЦФО(пЦФО)
	
	Запрос = Новый Запрос("ВЫБРАТЬ
						  |	ОтветственныеЗаЦФОСрезПоследних.Пользователь КАК РольВладелецЦФО
						  |ИЗ
						  |	РегистрСведений.ОтветственныеЗаЦФО.СрезПоследних(
						  |		,
						  |		Пользователь ССЫЛКА Справочник.РолиДокументооборота
						  |			И ЦФО = &ЦФО) КАК ОтветственныеЗаЦФОСрезПоследних
						  |ГДЕ
						  |	ОтветственныеЗаЦФОСрезПоследних.Пользователь <> &ПустаяРоль");
	
	Запрос.УстановитьПараметр("ЦФО",пЦФО);
	Запрос.УстановитьПараметр("ПустаяРоль",Справочники.гхб_РолиДокументооборота.ПустаяСсылка());
	Выборка = Запрос.Выполнить().Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.РольВладелецЦФО;
	Иначе
		Возврат Справочники.гхб_РолиДокументооборота.ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецЕсли
