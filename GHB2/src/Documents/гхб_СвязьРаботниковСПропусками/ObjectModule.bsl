
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	Если НЕ ЗначениеЗаполнено(гхб_Ответственный) Тогда
		гхб_Ответственный = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	гхб_Ответственный = Пользователи.ТекущийПользователь();
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	Для Каждого Стр Из Данные Цикл
		
		Если Стр.Использовать Тогда
		
			_Строка = Движения.гхб_ИсторияВыдачиПостоянныхПропусков.Добавить();
			_Строка.Период = Дата;
			_Строка.Регистратор = Ссылка;
			_Строка.Сотрудник = Стр.Сотрудник;
			_Строка.НомерПропуска = Стр.НомерПропуска;
			
		КонецЕсли;
		
	КонецЦикла;
		
	Движения.гхб_ИсторияВыдачиПостоянныхПропусков.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

#КонецЕсли