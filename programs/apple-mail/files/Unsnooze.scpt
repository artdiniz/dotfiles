JsOsaDAS1.001.00bplist00�Vscript_
]function xor(a, b) {
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

const Mail = Application("Mail")

Mail.includeStandardAdditions = true

// const remindMeMailboxAccountName = "Google"
		
// const remindMeAccount = Mail.accounts.byName(remindMeMailboxAccountName)()
		
// const inboxMailBox = remindMeAccount.mailboxes.byName("INBOX").get()


const inboxMailBox = Mail.inbox.get()

const encodedEmailStringIdentifier = encodeURIComponent("\n\n\n#######\n")
		
const regex = new RegExp(`${encodedEmailStringIdentifier}([\\s\\S]*)${encodedEmailStringIdentifier}[\\s\\S]*$`)

function performMailActionWithMessages(nudgeMessages, opts) {
	const allInboxMessages = inboxMailBox.messages()	

	nudgeMessages.forEach(nudge => {	
		const encodedCipher = nudge.content().match(regex)[1]
			
		const remindedMailId = xorSecret(decodeURIComponent(encodedCipher))	
				
		const theMessage = allInboxMessages.find((message) => {

			return (message.flaggedStatus() === true) 
				&& (message.flagIndex() === 1) 
				&& (message.messageId() === remindedMailId)
		})

		theMessage.flagIndex.set(-1)
		theMessage.flaggedStatus.set(false)
		
		//This updates mail smartboxes
		theMessage.move()
		theMessage.mailbox.messages.push(theMessage)
	})
}


                              
s jscr  ��ޭ