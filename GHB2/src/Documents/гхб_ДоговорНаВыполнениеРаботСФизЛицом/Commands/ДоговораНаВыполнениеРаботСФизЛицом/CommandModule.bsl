
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ЗначениеОтбора = Новый Структура("Сотрудник", ПараметрКоманды);
	ПараметрыФормы = Новый Структура("Отбор", ЗначениеОтбора);
	ОткрытьФорму("Документ.гхб_ДоговорНаВыполнениеРаботСФизЛицом.ФормаСписка", ПараметрыФормы);
	
КонецПроцедуры
