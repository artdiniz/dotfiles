JsOsaDAS1.001.00bplist00�Vscript_const Mail = Application("Mail")

Mail.includeStandardAdditions = true

const RemindDate = (() => {
	
	function is(a, b) {
		return a.getValue() == b.getValue()
	}


	function RemindDate({label, value }) {

		return {
			getLabel: () => label
			,getValue: () => typeof value == "function" ? value() : value
			,toString: () => label
		}
	}
	
	RemindDate.is = is
	
	return RemindDate
	
})()

const RemindDateSet = (set) => {
	function findByLabel(remindDateLabel) {
		
		const filtered = set.find(entry => entry.getLabel() == remindDateLabel)
		
		
		return filtered
	}
	
	function asLabels(values = []) {
		return values.map(remindDate => remindDate.getLabel())
	}
	
	
	return {
		valueForLabel: (label) => findByLabel(label).getValue()
		,labels: () => asLabels(set)
	}
	
}

const promptSnoozeTime = (() => {

	const tomorrow = RemindDate({label: 'Until Tomorrow', value: 'tomorrow'})
	const nextMonday = RemindDate({label: 'Until Next Monday', value: 'nextmonday'})
	const endOfDay = RemindDate({label: 'Until the end of the day', value: 'eod'})

	const other = RemindDate({label: 'Other', value: function promptCustomValue() {
	
		const promptReturn = Mail.displayDialog(
			"What time to snooze? \n\nCheck Nudgemail how to: \n\nhttps://www.nudgemail.com/how-to/"
			,{
    			defaultAnswer: endOfDay.getValue()
    			,withIcon: "note"
    			,buttons: ["Cancel", "Continue"]
				,defaultButton: "Continue"
				,cancelButton: "Cancel"
			}	
		)

		return promptReturn.textReturned
	
	}})
	
	const defaultDate = tomorrow

	const defaultRemindDateSet = RemindDateSet([
		tomorrow
		, nextMonday
		, endOfDay
		, other
	])
	
	return function promptSnoozeTime() {
	
		const snoozeLabelUserChoice = Mail.chooseFromList(defaultRemindDateSet.labels(), {
    		  withPrompt: "Snooze:"
			, defaultItems: [defaultDate.getLabel()]
		})
			
		const selectedValue = defaultRemindDateSet.valueForLabel(
			snoozeLabelUserChoice
		)
	
		return selectedValue
	}
})()

function xor(a, b) {
	a = "" + a
	b = "" + b
	
	const [longerString, shorterString] = a.length > b.length ? [a, b] : [b, a]
	
	let paddedShortString = shorterString
	
	while(paddedShortString.length < longerString.length) {
		paddedShortString = shorterString + paddedShortString
	}
	
	
	const trimLength = longerString.length - paddedShortString.length
	
	paddedShortString = paddedShortString.substring(trimLength - 1)


	const toBinaryStringArray = string => string
		.split("")
		.map(char => char.charCodeAt(0).toString(2))
		
	const binaryA = toBinaryStringArray(longerString)
	const binaryB = toBinaryStringArray(paddedShortString)
	
	const maxBinLengthA = binaryA.reduce((maxLength, string) => string.length > maxLength ? string.length : maxLength, 0)
	const maxBinLengthB = binaryB.reduce((maxLength, string) => string.length > maxLength ? string.length : maxLength, 0)
	const binPadLength = maxBinLengthA > maxBinLengthB ? maxBinLengthA : maxBinLengthB
	
	const paddedBinA = binaryA.map(char => char.padStart(binPadLength, 0))
	const paddedBinB = binaryB.map(char => char.padStart(binPadLength, 0))
	
	
	const binaryCipherArray = paddedBinA.map(
		(charCode, charIndex) => 
			charCode.split("")
				.map((bin, _i) => bin ^ paddedBinB[charIndex][_i])
				.join("")
	)
		
	const stringCipher = binaryCipherArray
		.map(i => parseInt(parseInt(i, 2).toString(10)))
		.map(s => String.fromCharCode(s))
		.join("")
	
	return stringCipher
	
}

const xorSecret = src => xor(src, 2)

function createSnoozedMailIdentifier(mailMessage) {
	const id = mailMessage.messageId()
	
	const encodedEmailStringIdentifier = encodeURIComponent("\n\n\n#######\n")

	console.log('Id: ' + id)
	
	const encodedCipher = encodeURIComponent(xorSecret(id))
	
	return encodedEmailStringIdentifier + encodedCipher + encodedEmailStringIdentifier
}

const selectedMessages = Mail.selection()

selectedMessages.forEach(message => {	
	const newMailMessageSubject = `Snoozed: ${message.subject()} | From: ${message.sender.get('name')}`
	const newMailMessageContent = createSnoozedMailIdentifier(message)
	
	const nudgeMailSnoozeTimeAddress = promptSnoozeTime()

	const newMail = Mail.OutgoingMessage().make({withProperties: {visible: false}})
	
	newMail.subject = newMailMessageSubject
		
		
	newMail.content = newMailMessageContent
	
	newMail.toRecipients.push(Mail.Recipient({ address: nudgeMailSnoozeTimeAddress + "@nudgemail.com" }))
	
	message.flaggedStatus.set(true)
	message.flagIndex.set(1)
		
	const wasSentSuccessfull = newMail.send()
	
	if (wasSentSuccessfull === false) {
		message.flaggedStatus.set(false)
		message.flagIndex.set(-1)
	}
	
	//This updates mail smartboxes
	message.move()
})
                              1 jscr  ��ޭ