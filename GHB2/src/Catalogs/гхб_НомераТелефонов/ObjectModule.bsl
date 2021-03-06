
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
    	Возврат;
	КонецЕсли;
	
	ВключенаАвтоМиграция = Справочники.гхб_СлужебныеЗначения.ВключенаАвтоМиграцияВБазыРИБ.Значение;
	ОтчетыКлиентСервер.ПривестиЗначениеКТипу(ВключенаАвтоМиграция, Новый ОписаниеТипов("Булево"));
	Если НЕ ВключенаАвтоМиграция Тогда
		Возврат
	КонецЕсли;
	
	СтруктураПараметров = Новый Структура;
	СтруктураПараметров.Вставить("Ссылка", Ссылка);
	
	СтруктураСвойствКЗаполнению = Новый Структура;
	СтруктураСвойствКЗаполнению.Вставить("НаименованиеТелефона", Наименование);
	СтруктураСвойствКЗаполнению.Вставить("НеИспользоватьПриРассылкеСМС", НеИспользоватьПриРассылкеСМС);
	СтруктураСвойствКЗаполнению.Вставить("НеИспользоватьПриОбменеСАД", НеИспользоватьПриОбменеСАД);
	СтруктураСвойствКЗаполнению.Вставить("ОсновнойНомер", ОсновнойНомер);
	
	СтруктураПараметров.Вставить("СтруктураСвойствКЗаполнению", СтруктураСвойствКЗаполнению);
	
	ОбменПрошел = гхб_МобильнаяСвязьСервер.ОтправитьСправочникВБазыРИБ("СоздатьИзменитьЭлементСправочникаДанныеТелефонов",
																		СтруктураПараметров);
	Если НЕ ОбменПрошел Тогда
		Отказ = Истина;
	КонецЕсли;																	
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли