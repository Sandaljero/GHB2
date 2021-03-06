
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

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
         Возврат;
	КонецЕсли;
	 
	Если (РежимЗаписи = РежимЗаписиДокумента.ОтменаПроведения) Тогда
		
		//Отказ = (АвтоматическоеСозданиеДокумента ИЛИ (НачалоДня(Дата) < НачалоДня(ТекущаяДатаСеанса()))) И 
		//	НЕ РольДоступна(Метаданные.Роли.ПолныеПрава);
		//	
		//Если Отказ Тогда
		//	
		//	_ФЛ = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыСеанса.ТекущийПользователь, "ФизическоеЛицо");
		//
		//	_Массив = РегистрыСведений.гхб_РуководителиЛокаций.ВернутьЛокацииПоРуководителю(_ФЛ);
		//	
		//	_МассивЛокацийОтветственные = РегистрыСведений.гхб_ОтветственныеЗаЛокации.ВернутьЛокацииПоОтветственному(_ФЛ);
		//	
		//	Для Каждого _Локация Из _МассивЛокацийОтветственные Цикл
		//		Если _Массив.Найти(_Локация) = Неопределено Тогда
		//			_Массив.Добавить(_Локация);
		//		КонецЕсли;
		//	КонецЦикла;
		//	
		//	_МассивДополнительный = РегистрыСведений.гхб_ДополнительныеОтветственныеЗаЛокации.ВернутьЛокацииПоДополнительномуОтветственному(_ФЛ);
		//	
		//	Для Каждого _Локация Из _МассивДополнительный Цикл
		//		Если (_Массив.Найти(_Локация) = Неопределено) Тогда
		//			_Массив.Добавить(_Локация);
		//		КонецЕсли;
		//	КонецЦикла;
		//	
		//	Для Каждого _Локация Из _Массив Цикл
		//		Если Помещение.ПринадлежитЭлементу(_Локация) Тогда
		//			Отказ = Ложь;
		//			Прервать;
		//		КонецЕсли;
		//	КонецЦикла;
		//	
		//КонецЕсли;
			
		//Если НЕ Отказ Тогда
			РегистрыСведений.гхб_АктуальныеДокументыКонсервацииПомещений.УдалитьЗаписиПоДокументуИПересчитатьДанные(Ссылка);
		//КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	
	//Если (НачалоДня(Дата) >= НачалоДня(ТекущаяДатаСеанса())) Тогда
	
		_Движение = Движения.гхб_СтатусыКонсервацииПомещений.Добавить();
		_Движение.Период = Дата;
		_Движение.Регистратор = Ссылка;
		_Движение.Помещение = Помещение;
		_Движение.СтатусКонсервации = СтатусКонсервации;
		_Движение.ДатаНачала = ДатаНачала;
		_Движение.ДатаОкончания = ДатаОкончания;
		_Движение.ПериодКонсервации = ПериодКонсервации;
		_Движение.ПериодКонсервацииСтрока = ПериодКонсервацииСтрока;
			
		Движения.гхб_СтатусыКонсервацииПомещений.Записать();
		
		РегистрыСведений.гхб_АктуальныеДокументыКонсервацииПомещений.ЗаписатьДанныеПоДокументу(Ссылка, Помещение, ДатаНачала, ?(ЗначениеЗаполнено(ДатаОкончания), ДатаОкончания, гхб_ОбщегоНазначенияКлиентСервер.ДобавитьДеньКДате(ДатаНачала, 6)));
		
		Если НЕ РегистрыСведений.гхб_СобытияОбъектовБД.СобытиеПоОбъектуБыло(Ссылка, Перечисления.гхб_ТипыСобытийОбъектовБД.УведомлениеПриПроведении) Тогда
			ОтправитьПисьмоНаСервисДеск();
			РегистрыСведений.гхб_СобытияОбъектовБД.ЗаписатьДанныеСобытияОбъекта(Ссылка, Перечисления.гхб_ТипыСобытийОбъектовБД.УведомлениеПриПроведении);
		КонецЕсли;
		
	//КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОтправитьПисьмоНаСервисДеск()
	
	Если ПомощьIT ИЛИ ПомощьАХО Тогда
		
		_Адрес = Справочники.гхб_СлужебныеЗначения.ПочтовыйЯщикServiceDesk.Значение;
		
		Если ЗначениеЗаполнено(_Адрес) Тогда 
			
			Если ПомощьIT И ПомощьАХО Тогда
				_СтрокаПомощь = "АХО и IT";
				_СтрокаПолнаяПомощь = "Помощь АХО<br>Помощь IT";
			ИначеЕсли ПомощьАХО Тогда
				_СтрокаПомощь = "АХО";
				_СтрокаПолнаяПомощь = "Помощь АХО";
			Иначе
				_СтрокаПомощь = "IT";
				_СтрокаПолнаяПомощь = "Помощь IT";
			КонецЕсли;
				
			_Текст = "<p>Добрый день!<br>
				|Для помещения изменен статус консервации и необходимо создать заявки на помощь " + _СтрокаПомощь + "</p>
				|<table border=""0"">
				|<tbody>
				|<tr>
				|<td align=""left"" valign=""top""><b>Помещение:</b></td>
				|<td align=""left"" valign=""top"">" + СокрЛП(Помещение) + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Ответственный за консервацию помещения:</b></td>
				|<td align=""left"" valign=""top"">" + СокрЛП(гхб_Ответственный) + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Статус консервации:</b></td>
				|<td align=""left"" valign=""top"">" + СокрЛП(СтатусКонсервации) + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Дата изменения статуса консервации:</b></td>
				|<td align=""left"" valign=""top"">" + Формат(ДатаНачала, "ДФ=dd.MM.yyyy") + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Период консервации:</b></td>
				|<td align=""left"" valign=""top"">" + ПериодКонсервацииСтрока + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Дата окончания действия статуса консервации:</b></td>
				|<td align=""left"" valign=""top"">" + Формат(ДатаОкончания, "ДФ=dd.MM.yyyy") + "</td>
				|</tr>
				|<tr>
				|<td align=""left"" valign=""top""><b>Привлечение сервисных служб:</b></td>
				|<td align=""left"" valign=""top"">" + _СтрокаПолнаяПомощь + "</td>
				|</tr>
				|</tbody>
				|</table>";
				
			_Тема = гхб_ВзаимодействияСервер.СформироватьСтандартнуюТемуПисьма("Изменен статус консервации для помещения");
			
			гхб_ВзаимодействияСервер.СоздатьЭлектронноеПисьмо(_Адрес, _Тема, _Текст);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли