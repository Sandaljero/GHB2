
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ЗначениеОтбора = Новый Структура("Сотрудник", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор", ЗначениеОтбора);
	ОткрытьФорму("РегистрСведений.гхб_СостояниеРаботниковОрганизаций.ФормаСписка", ПараметрыФормы);
	
КонецПроцедуры
