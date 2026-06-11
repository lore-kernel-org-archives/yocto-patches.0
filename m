Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD6CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:09:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45089.1781183340227653687
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 06:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Vd/9weQT;
 spf=pass (domain: cherry.de, ip: 52.101.84.16, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDvQxxqm9NOLm4aUF8R03Qh9QkFsms690i5Id+K3SFCxnh1YfZvbmsmdVQpGDeHua2eREpfcdoFTp3OITt60lN1JgMCz5gdyJxSHxrY/yD6rbrEGSLwaGsYpSNfTiiAtcTnXkAUk+SKukOydavJTkE+E8Ye3dqi2Xhc18qWf4G20azgM9CBc6ef1FL63JDNgOV3lont4fILrrHNAxFxdNmThLEoLU2zvveEwWLQJY7zOvJLc42B1aSrUN5eSZtsZ6y/n4bA6HwqM84Epv98jNFsMGdonjJ2Hm+XYlmdYGYpQedISkErL5Rkj4os4U7rAk0c57yUGcyUntYVuwoX4AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NS0b7a3Fuli5UvlgaGDfRsBg1EMAGfMcj4Wdh8jR4bI=;
 b=Av7t5DaPjOkT8igx0Hprw0din5ver+otYRRB6dNTg75SfQfS4KFh7TCjMRBQk3MJmwpa9v9lf/H2/ETJhKjHHJWbT9ofRIy0w/QJFxGM+kVX0OJBhnM2YAeGJcu/35bZwmPapjFnmT3NCNvGl+uV9UMecq0vfjUqYNILh4NRqbWgNswZz9u20QkKOlmFenNre7etwUi35Ov/kjitCcczqrQwpBBZlYXDNw6fvhL2It/gWk8KQRLePXlDfIV68WCouOu0phy7ClYw3MBHzjDYhN+ShCtxCSEiMefoJCcimW1hKZkwL1u2XF1pMWPVyR6U1LRzJ0h48BVM5NcfBg8dwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NS0b7a3Fuli5UvlgaGDfRsBg1EMAGfMcj4Wdh8jR4bI=;
 b=Vd/9weQT6sptb/1yArL86qgv/EU7/Q71JDlna1bZfvuhfuszs9BrTUzl6LzJIbf/pOMw0jFmKUM7pmg+x0g5j4UCpTlSOebXRXy1WIsgXS6motCJvDSFB7YGpN0yJIjITNDoo7vyjhoKWP+F0q4q6o3O0IFnqNVlh/PIRQ+A+j4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 13:08:56 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 11 Jun 2026
 13:08:56 +0000
Message-ID: <b64f1fff-20a2-428a-8dc6-281fdf30b4a0@cherry.de>
Date: Thu, 11 Jun 2026 15:08:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wic 2/2] README.md: add Trevor (the maintainer)'s mail as
 Cc recipients
To: Trevor Woerner <twoerner@gmail.com>, Quentin Schulz <foss+yocto@0leil.net>
Cc: yocto-patches@lists.yoctoproject.org
References: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
 <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
 <aiqulowvm9FN-Wug@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aiqulowvm9FN-Wug@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM8PR04MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfb6cf3-659f-43b5-3a4d-08dec7ba980a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|9063799003|56012099006|11063799006|5023799004|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	Pfef735AVNxskR0qTIG89iIbK1pen113+hqpR74lo/DUt3usZj046UJOtFb3RdGf8Nn4Pk0/67Mp5kYfpi8OHQU3/Sihiladp8uQHEuvnE/M3JoImI+h1QYViEw9wOsAFU8ebFwhUmcIeGespAHkd3+mkIDndYcLDvnWZRmBo95cVcroF6PyNB1FKSYGUXNSMRHPJuO96Je98qqdJpaRQP1ri2ZzfqvigEO5DXsfqSA7Ohb31WslvJlz607VyBIPLpUkXVf8nV/N93upgbJJDs67XzSoz+8+NJuiMrG0wPsKqQpLp5yn7Wb1AReRZHvFw2KMwq520hDRVvuvwCVYehWnw/rAYu2o27qA/EBb0i3cE9Q94IZ5P8K9nXb8NPzBB8/BcrGfcqU5wnyF2IP0nALMiR9F7r228cRcsRbnWzDSD4NIgUCp/NzIUl1ARUlUeDWJx+K0/biDvhbiRwLpiVqY9d5e9azc2brrNI3CrOhp6cwXdixFyGD+lG3P790Yw46LPVsptatvVyX9GqyLcRMJ9LBzuLYGBEmR64qsL26rolt5iotIFsTY8bjMYx09rt23xidFkZ+RL0l91YN1E24iDFM/PNxRghckqMsykPgbqnHQJaD5j4eQ1m5OAqwvdO70f4wLcfT/0KA2fgjrTA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(9063799003)(56012099006)(11063799006)(5023799004)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rnk1R3o1N205WTg3U1BYSll2WVBRUGVQS0F5VkVzeC9mcW5JbnUzVEJFRFFa?=
 =?utf-8?B?TFJKeUVDRm55VTJDMy9RTFFrNnlFZCtRRFVuVmt2SWhYVkcvMFJNN0FSM1VS?=
 =?utf-8?B?QkpxUUNRSjBhRHMxR1IwQkF4bjdmSEtkaXRHc05pRGdhUzY4Q3hQNjZqSkww?=
 =?utf-8?B?QURkMloxbGV1WlhCY2hBMy9SRHBCZWhHQmtKNXN3SDM3MnVITXVYbWNpbmFQ?=
 =?utf-8?B?ZUI1RCt1V0VDNTNUZzFqS2N1ZUoyUGdaV0hEdGhyYzJqT3Joa3ZBY2Z5VWJq?=
 =?utf-8?B?eTNGU0dSWUZuUGt5WTNDK2JnWU8yWkVScE9pOFQweW9Eb0lWcTNibWkyNEZi?=
 =?utf-8?B?aFdqUWJEVnNqdnVoWmNjLzVPakdseTQ3UmNodkFmZ01RRjI1UFAzMlV6b1ZL?=
 =?utf-8?B?OVJxVnQ3aWgvMUdDWnR2dzYrVmpDUDJJNUpDb1dyQVlJaERKM3Y0dlg3OC9H?=
 =?utf-8?B?a2J0TkdwdExCbXBzU3NBOFBJUExXVVRNVG0veVNNMUdLMXVFZEJlUll2Zm1R?=
 =?utf-8?B?c3Z2djNwMUI4TVdaRUlZNVJQTFhXSFJYZG5aMHZERmpwZGlJU29wTUZWRWxt?=
 =?utf-8?B?WHd3cXdUZDNFMHJpOFY4YURXVEsvZERuUUFTVTV0VnVTVmRod3VkUDRkU0U5?=
 =?utf-8?B?RU9QaGRJaFFqRmJXZ0JkTHU3OUVMcW9reTRLd0VMNUwzRTB6cWhScnV4QTA3?=
 =?utf-8?B?SEEzbkZiVUduUHBJZkNWdmhvTE1FS2R6Y2pJb1Qvc0phNElrczVzblMrQjdE?=
 =?utf-8?B?SmRqSC9kMjlwVzRRMm5lNCtMZFYrMlo4ejZqMWhlMWxSR1NRU1IzamFRdFdH?=
 =?utf-8?B?czNIVmtHd0hBMmNxbmRtdk1WT0pTeFVSS2c4WXJQSVpST0ZUVWxLZDRnYVZ0?=
 =?utf-8?B?dFNFNWxCN015RW96SFRET1o3N1dJRm1YY2NxMmpKYnVJeWRUeGlZWjNJM2ln?=
 =?utf-8?B?dzkwaWdxYm4yQTBFcHRoN2ZweWp2LzRaRUxqZTBYNzJlZFVxUm5MUEdPR2E4?=
 =?utf-8?B?b3p5TVJLaDdmenIwcTc1V3lqZmpjV0NoeDFZS0ZLbUEwYSt3SDVpNDlidmRG?=
 =?utf-8?B?RHBjRGo3MHU3R3NsM2hHT1MrQVczUjZ0MXpySWpqek9MWGxIU0VJTmlxc05F?=
 =?utf-8?B?K1VtRWhuRHc0ZlZCYWVzYU5NbUNLZm1hZDJWM2s1eFRPakp5T2t5TTAwc1pp?=
 =?utf-8?B?U05EZ0FhY05PWGFNZ0RudlBNbzVSTmhrV1NudWNtUlovbEpmZzZkZ0lEL3VO?=
 =?utf-8?B?S3IxSG95ME9XbGw1ejlHMUNXSWRvN3FIbUlyc2o3RXFMWkhoaDY2RnQxVHht?=
 =?utf-8?B?RDBIQjNXMVgyTW94MDIzbk1nYlRVYVJmdkRwVm9weHJoK0pyVVJRazBiWWJm?=
 =?utf-8?B?SnNwYVJ6WVFiSzZXc0Q5OUwraUZkQklid1Y0ZUs5bSsxV3Z1T2xXeHlZalg2?=
 =?utf-8?B?d0Z3TmJBWStDb3RCTWVuRnFhSjBxWlJPNHdXV0hvUEJKbmRkRjF1d0QzOFM0?=
 =?utf-8?B?blBMMzhOZkw4MFFaQU5TN0ZvQzVFQVlkZ0VYREloa1BLSTFYQk5FeGluNFk4?=
 =?utf-8?B?anQrdGJXNmxDZUtJUEhnRllLMTNMVUhXMU1rSkNXRGpXT3lUeDdlT1dFc1k4?=
 =?utf-8?B?Q0syczdNYjNQajVHRmYrcGY1T3owOUNSNk0rUExCbWZ2U0tkWG50RGZoUDgx?=
 =?utf-8?B?TGdOdDJqMzFEa1l2R1llQXFWUi9mVlNrQU95SG40N3BXR1R1alNNS0VwRGRq?=
 =?utf-8?B?cTI2RSt3eW5sblYwTmxva1p1cTlUc3FoTnlTN3FmbUxaL2lBeGdqRXdlVWpx?=
 =?utf-8?B?TEd3WkYvNDM3UFhPOVpoUFFDTmVkdi9kVTc5cm1LQ2l5VGRpanVFYzcrRnk5?=
 =?utf-8?B?eU16MVRjNENxcEl3czdQV2ZKbHBVK2dLTExFSUtRc1dDWC85QzRqcVgvcUph?=
 =?utf-8?B?dkVOQ1ByVkN2VDRHMHB1QVZtYkhycCtYTXhqQ2Q4alF1RFdpalNkVjlqWmQ3?=
 =?utf-8?B?Tm9rSmR3ejNzNnU0Z3dnaitLejR4NklRZy9QWVY1TmdLUkNxb1FFd0dUMlF1?=
 =?utf-8?B?dXFZbXRLY2NDdnBVMGcxRHB1eFliT29NUW5xQzh6NFhFSVVRQVZ4UHlueGh1?=
 =?utf-8?B?ZnhRN3pkeHdiTnpOVlRxVkwvWmN0WnJobXI1OFprWCt6dm9UZWFsOVpKN1VL?=
 =?utf-8?B?cDB5MXc1MW1hQmt2OHA4cnhRS2FZOGg2b3NuRGdnYm04ajNDRGhQUDM4TDZa?=
 =?utf-8?B?TkV0TkY4ZXNvb3JNdTZCTURGaVo0bUl4cTI5Z2drMVMxN1FZN1dqYnFnM1ZQ?=
 =?utf-8?B?M25GaHBHdFhxOXZvMi9yZDhobjA5bFJIQllUV1dGVi8wem4zL3JSQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb6cf3-659f-43b5-3a4d-08dec7ba980a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:08:56.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucRGsuYE8jCpkaXkwDDT2Ul88PIuLJmdF6l8xtSlnyJTRZuRJ9C5kv4l/145P3m7OBr0mAQ0llQAnPJ7TP1a0Gf8NHEnMS0hcmOqlKBLLjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 13:09:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4216

Hi Trevor,

On 6/11/26 2:48 PM, Trevor Woerner wrote:
> On Mon 2026-06-08 @ 12:47:59 PM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> The instructions now match with the .b4-config file.
> 
> Sort of... I believe the b4 emails will read: "[PATCH wic]" while the
> cmdline emails will read: "[wic][PATCH]". No biggie, I'll find them
> either way.
> 

Details, details :D

I believe this is actually supported by b4, via the b4.send-presubject 
configuration knob, only available since b4 v0.15 (end of March 2026). 
Distros probably aren't all shipping this version and if using an 
earlier version it probably will do nothing. And we don't want both 
otherwise we'll get [PATCH wic][wic] when using v0.15+?

>> Suggested-by: Trevor Woerner <twoerner@gmail.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   README.md | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Applied to wic, master branch. Thanks!
> 
>>
>> diff --git a/README.md b/README.md
>> index 0066ae4..3259019 100644
>> --- a/README.md
>> +++ b/README.md
>> @@ -57,9 +57,13 @@ When sending patches, please make sure the email subject line includes
>>   "[wic][PATCH]" and follow The Yocto Project community's patch submission
>>   guidelines.
>>   
>> +The patches should be sent with the mailing list (yocto-patches@lists.yoctoproject.org)
>> +in the To: recipients and the maintainer address (twoerner@gmail.com) in Cc:
>> +recipients.
>> +
>>   When generating the patches manually, this will generate what's expected:
>>   
>> -   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix='wic][PATCH'
>> +   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --cc twoerner@gmail.com --subject-prefix='wic][PATCH'
> 
> If my understanding is correct, in markdown, in order for this to be
> offset as a proper code block, it would need to be indented 4 spaces,
> not 3. Regardless this isn't relevant since we're not hosting (or
> mirroring) this project on github, and the markdown renderer on
> git.yoctoproject.org doesn't seem as in-sync with github's version of
> markdown. Either 4 spaces, or wrapped in ``` delimiters.
> 

Markdown is a PITA, you never know what's supported by whatever parser 
is used. Going for the "original" Markdown is probably best, but who's 
gonna check if the syntax is proper for new patches?

> In any case it doesn't look like the git.yoctoproject.org markdown
> renderer understands ```bash blocks, so I'm posting a follow-up patch to
> fix it all up.
> 

It seems like it could via an extension, c.f. 
https://python-markdown.github.io/extensions/fenced_code_blocks/#syntax-highlighting 
(if Archwiki doesn't lie on what markdown formatter is used by cgit).

Thanks for the fixup!

Cheers,
Quentin

