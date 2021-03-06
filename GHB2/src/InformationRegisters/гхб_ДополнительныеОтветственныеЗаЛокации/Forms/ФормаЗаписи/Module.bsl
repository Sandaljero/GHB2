
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если РольДоступна(Метаданные.Роли.ПолныеПрава) Тогда
		_Массив = Справочники.гхб_Помещения.ВернутьАктивныеПомещенияПоТипу(Справочники.гхб_ТипыПомещений.Локация);
	Иначе
		_Массив = РегистрыСведений.гхб_РуководителиЛокаций.ВернутьЛокацииПоРуководителю(
			ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ПараметрыСеанса.ТекущийПользователь, "ФизическоеЛицо"));
	КонецЕсли;
	
	Элементы.Локация.СписокВыбора.ЗагрузитьЗначения(_Массив);
	Элементы.Локация.СписокВыбора.СортироватьПоЗначению();
	
КонецПроцедуры
