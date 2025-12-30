Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2AE94108
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 00:51:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.55721.1767055856861253446
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 16:50:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=DD4BuvdT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=545943993c=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU00H0n3795580
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 00:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fZGq49YxnqUdFsw05FJnbYcX2H+oV5iOyF2DI7rw5uU=; b=
	DD4BuvdTfOjHVkUuo+ut4sFR2q8+gUl5CvGyVmq3eVVNLU3Jl3WinKFuxJJYjpGo
	MUeQw7zErkAcpJw2EbTHPOYKUK66mK3pH9mHrer9UwHFMrwqAac5p5EDiNI2j7dv
	izKVp0bTwhwG+4RLujqOXAkEFu4VRGXdsuo64lVb4JDKyOFqs7koPEhOSMySw6wj
	jCDvV3Q9LfaVG/B6IZZPEM+KFI8Y8LYvon+2LeOFZ4vH+Paody5AUmRRbL+2mVpl
	lfiVi4OhCcjYiDKKscxYTSAf8+vn6r19rMtPhooFWeyGQ1nKGxQm2IfPvNS0/lUw
	hM+5itw9ieqzQAsGuL+RTQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ba6e4taeb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 00:50:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCELbGSq+U0XrqteRzVfZg8h50NNdqzG/JwxP1r/Qdo6k7DN8R0WhQa+8uSTPEGum2WHPSB98nUndvmA5WWxP5AAsPFMBVp8/0mFmfwoGCpRYnrPPdXlbv9+60JCK+BFU3DJ2IxT6/iUuSh5jGL2FUojUds7Q9JgTiXaTiPPUHerZZbR/EyN7gMlknRIoWlTCLZLSrGvIOmIO+57YoIbmAy60iWvhQ1Zcus+NRd1IPCReiEm/D8ZXeg3YXoswad3fdF68Z8sqxkoL+QG7UTvm4UPS5WWwx61L8nL5do5lJfWE0F7t6tZ+S8S3yGP1x1WBEiWie3MAPTAALmMccRWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZGq49YxnqUdFsw05FJnbYcX2H+oV5iOyF2DI7rw5uU=;
 b=Enq3K9Nu4dcyfAzoh+WlIq1bjgYs/JUMeTE2jMFFHsNMrwteE2/pV1Ob5Dj5WYCt8zVpGK3JOyecKCZVmyFo0o1CKFbZ0BxDYUhmtmgDDKn8mVY6dxN/BPBh1cgb8+np0Re6TEfmLgyY5cSuv+RO/hHNd4qg9mWD0eUzRkp1uvQ7Gr1x1a+eYFJEU1+tMe0y3Dd9xjoYuGrS4RNF9fHvQ0rA5bZkS+oI2JsXXMQ/K5mFDtGsNnaoKmN9QIjuiFKIjudPSBEMiP32mauHECSgnfCaF42LATDWjUUVq3lDGafTnTVKGdMV/KaHixs8daCpItaf1PoEoXrUa3eUPF3PdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CY8PR11MB7798.namprd11.prod.outlook.com (2603:10b6:930:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 00:50:53 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 00:50:52 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "Hao, Ruiqiang" <Ruiqiang.Hao@windriver.com>
Subject: RE: [yocto-patches] [PATCH] dpdk: rename recipe to match tag format
Thread-Topic: [yocto-patches] [PATCH] dpdk: rename recipe to match tag format
Thread-Index: AQHceKcr6EmItijNaUqJTyPWJOYb9rU4a38AgADvxeA=
Date: Tue, 30 Dec 2025 00:50:52 +0000
Message-ID: 
 <CO6PR11MB5602A9F279564F16035C4B13EDBCA@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20251229093946.2776440-1-ruiqiang.hao@windriver.com>
 <CA+s=J=wXCW+og+M-kTP3YmCPTEBgfRGH9P9BvYm_mJW4TQWUfw@mail.gmail.com>
In-Reply-To: 
 <CA+s=J=wXCW+og+M-kTP3YmCPTEBgfRGH9P9BvYm_mJW4TQWUfw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ActionId=61e0e5b5-385b-4d6f-9554-b15d33faeaed;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=0;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=true;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2025-12-30T00:50:26Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|CY8PR11MB7798:EE_
x-ms-office365-filtering-correlation-id: d52997b8-3fe0-475e-5a21-08de473d7bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|4022899009|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?T1cwT1E2Z0lReHhteWc5SHNUMDZxL3VGRXJlVDJqQjR1blpvZWRSTVRpaHc3?=
 =?utf-8?B?SzJvVmlqT0NTUGtOUlh5V25HZ3FMUHhtQ244a0pTbUZEcVdjZFJRai9RRTNm?=
 =?utf-8?B?YnhjUjR1K3pOVi9rcGpQMnMyNmcrNHBVd1d3dGQrb3pDZjFyS2pWY3RHMXVU?=
 =?utf-8?B?UzZqWU10NGpCK05SS3hLd0N3R0RmOVo1SHBqR0Q3Q3QyT1dwdWp6UDlKRGtZ?=
 =?utf-8?B?RE1QdDBuR2o1MU9zYXFMMTNacG1LZGFEQTA2SVdqQ2Y3TTUyOGFleE84VEFS?=
 =?utf-8?B?UklINTFrY3JVZ2tXMWlMaDVjVmpnQ1Bka09TUUFkRUl4Vk5JYnJ6TnRzbEZ2?=
 =?utf-8?B?N2xQclV4TnZ2SThwQW1NODJvaEIzajhkd0luK0dIV3VjZkRLaXdYZzdRZXl0?=
 =?utf-8?B?RmFTR2dpUHhBeXk0UmRTQ2JUcFVvTHdkdHhPa0Y2TTRuMFR6aEZJSytFOW41?=
 =?utf-8?B?L2o2QXBhb3dnaHJrSFlQRWNKL3J1WTlWVGhoRXFQWnFOYUdPV04rTituZlFB?=
 =?utf-8?B?NzltZDV4WVFBZVJKV2k2UysrWUE2WmdoWmNoTUlhYk9SNjVWaERKQlVmNndz?=
 =?utf-8?B?TXk0TmRBbUFWdkVYUjNmNUlQNEo1V2ZsUm9jQmtVUktBdFpjSjNkRFIwRTU3?=
 =?utf-8?B?S0Y4dk9tYTFWanFUa1BMU2ZWRG9yVHJhNk9WeVVXWFZreUJOMWZxemRJMnFj?=
 =?utf-8?B?NmFWV3BOVHlKNlBZdGVaRkJ1UWNQaDlHcDROeEo3NzhXZy96TXlkMjFkZ04y?=
 =?utf-8?B?eGIrMEtLeTN4MTRZOWVqZ1R0Y09hU1ZjWGpuZkJtMFByczlDZGNQZ01pZXg5?=
 =?utf-8?B?SDhnZ1gzcmova1hMc3Qvd1lQeXI4TzhSY3JFVVFNOGVuNVBqanB3MUhCcERv?=
 =?utf-8?B?MGM5L2RRVXpOWWVHZjR2cHg4Y2ZLb2RiU21UUkYxTEFkK1grME5Dd3ZvTStM?=
 =?utf-8?B?dnJlMVlHeGJYVWFXN3lOL1Z6R01SVnZnbHNJbVFEM0U1Sjlvd2lUQURKRmJj?=
 =?utf-8?B?T0g0cHIreDZhVG5CaXkveTVaajBVU0pMY1VTZDBwejJCaGd1K29ybXB4QitV?=
 =?utf-8?B?eG1sTUgyNHlxTTlQY25jazcvWEJvdDRjL3FZVkNYcys4U1IzQzZYNnVJWUI4?=
 =?utf-8?B?YUJrZWk1aC9lRXdxTWY0M2ZOZDhUN2N2cktlZ0Y1WmNsa204dVViWm5SWU0r?=
 =?utf-8?B?dzBPSC9hWEhkVWZYamVsbDVqMkRqeWplaU54b3hZemVOZm43UGU4eEdSbHJS?=
 =?utf-8?B?WHZ3cmxTMXdMS2Vmd1JMY3RsSjRZbXN6NEdHS2Z0VGpLYzVESUppOHZ1RVl1?=
 =?utf-8?B?b3Y5NWJoeHNsVytEYkZUYStxVWk1dlR2Vk9ZY2Q4U3dwcjF6SEFzMXQvUElU?=
 =?utf-8?B?WkVkWFlRRDd2MUZmWExzeW54a3YrWHgycU54UzJGOWFaS0tMTWRPLzZMZ2I5?=
 =?utf-8?B?N1dVcWVwZGxFU2J4MFRGVm5IdmMzRG5oRWgyVkRMVThaclVpcjMxVk9DbHNq?=
 =?utf-8?B?T2VMU1pwZ2ZSd1ZQcHJPcEpBZUY0WDArWTA0eVR0YWZmalJPMkZlZk1LYWpj?=
 =?utf-8?B?MTJZQTIycXR3ZXZmU3NRZ3k1aStlS2txVzlTQm8xQkZvUHdmRDJKUGZmMDVx?=
 =?utf-8?B?OWlONDNlWFBTL2NHUkU0a2U0RHN0ZXhJVjNLTXREVGxONVVMYndFYmlIWDZ6?=
 =?utf-8?B?dVRMMTVzb2NtbGhRSndEemxtREZpckhaR0txT1lMRXRpOU5XOCt1TWQ5MURk?=
 =?utf-8?B?bHBuUVpOdzZGS0kxazNHRVBxSWV6UXRmMFE0STF4ZThJMW5odkFKVndjMmZT?=
 =?utf-8?B?R3ZHazJEQWZaYzIySnhoNkhnVC9pUGRLaXFlUElxVUp2aDVRL0szT1ZtWkox?=
 =?utf-8?B?SGdZaGpXbnkrR0xTRDRqbjVJYndTK01jbnVhNXZlSjBkcTErZllHWXFVZWZ6?=
 =?utf-8?B?WCs4SjJIZmlhU3RXSis5c1AzY1Z5MUpnaUg2UXdkRTFjSmtaaHJRNVlQWmJG?=
 =?utf-8?B?T2h0ZEJrbDVUQ1pUS1ZYR0RONDVwVmZHcjNOS2t1UHQ4Q1dub1NLMFFud1kw?=
 =?utf-8?B?RnMxeG5hb2k4TGNtbzRGakVkazgzYldUVE5wZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WEt5WGNlaGRKd2lRQ2NVREhnZ2g4VDJLTjhmZStMM002TER5RnArbS9hR25n?=
 =?utf-8?B?aW44TlkwSzVBY0pJVmJ2YTJVVW5zdEVzOWVVRjQzV0FZMHBDK2pERndocFBC?=
 =?utf-8?B?MERaVlhoVzd1T1hXL1lFNnptK2Qzek4wZ21Ha3grNGcrTDhqTE16VjA0Q3ZQ?=
 =?utf-8?B?NmZzZlFjbmdFZHNucldZYzBTd1JKWjhkUjZmMkRqR2htNDgwMTFZclpCc1ht?=
 =?utf-8?B?U2swbjFVdGFvUTdDVnc5ekt4QUFBa2kvaGNFS2dxWk8zV0NLM05EVHZvL2RV?=
 =?utf-8?B?cmpOejZqOE9KeWlSQzZSa0p5MjloNE85MUl4eHQ2K1lhVUpOL1NPWU9zVW1Y?=
 =?utf-8?B?dGRNTmltdkxicm9CaS9ibmpCV1VTRkZoaXNKVzZoTlN3WUExMC9RYnB0ZzFJ?=
 =?utf-8?B?dDhUbkhzUytwTlpMdFZINjhlZWJWZTZVQXJycXVEemFtVm9aTk1Ec05YQTlE?=
 =?utf-8?B?WmwrWnYvK2NOeC80UU5COUZaOVNjVXV5Tjk4emFBOHErdktqOTlKTlE0UmtO?=
 =?utf-8?B?UHJ1cHFDRXZGY0w2bC9aQVRQUzFhY2lGaG9rL2RYSkNFMnRSWDFJOTNtSVIx?=
 =?utf-8?B?VWMrOHduRXlveVlPb0hiNUVTWkh2RWh2SmFQcnNaSFBSRW5TdVBrUUM5OXlM?=
 =?utf-8?B?eHVPRHVwY0FZdmhVZUsvMzV6S2pEQ2kzRGRlSDBIek1JcWlNbVpNZjRvcDFh?=
 =?utf-8?B?amtKakNFc2toSTdJNFZEYm9JV3dxcmRRSTVKR1ZXd0RzT3YvVXhSTWlYbXJ6?=
 =?utf-8?B?SHYxdENLTnNvanlvVVVwZlRidDNjOEtKQjNwRmt6TnZkMkg2dkVDS3dqc01O?=
 =?utf-8?B?c29UdjJtM1BPNWxwUHpSNkpUekdtMElGd1EvMXVuYlFIczB4S1cyTVQzUXVZ?=
 =?utf-8?B?WmRpb0ZCWkljdmVGZDluVkFxd1BGUnY4OTBFUEFWdVhlbkNXb2p6am5zazdn?=
 =?utf-8?B?ZDhYa25RZjdKRStibUdhT05qTEUweEdzTk1GaURicUFKWFpKT2YvUjEyTkRh?=
 =?utf-8?B?bnJNODFveXF6MDM0UVZFdHd4WlQxdGc0Q0NTRkpsVlJpaWZ2TUZmTVgvSnlU?=
 =?utf-8?B?amErTkNBOW1jTjhtcXUyZHdtcWhRL3pNTWVZcFNVbURpNTJrUFdLcUhmUlFk?=
 =?utf-8?B?WlljbFFicVplbUZWYUFvVVVFbk42dFN1MVhSSXhRYUNmK1Q5eWw3U3c3ZEs0?=
 =?utf-8?B?TGQ4Qmp3UTduMU5JZDQ2YkVaNUdIOHBUeUVzS1hQM0hYbEd1S1I3Qm11ak1u?=
 =?utf-8?B?OWV0bDlobjUyb2dFSHBMMGtyZFZ1YVdiVXRzZkRXVmtHeU1oRU84ZlFVeHE4?=
 =?utf-8?B?QzdUdUhLcmFtSXhXUlNlRWVGeXpCTkdvdEo4VTlqaVFmbkhRbTF5aVc2VFFI?=
 =?utf-8?B?MGZVK09DQ0txU1JjcmNyUWhCSWFSZ0lIdWZuL0ZZUEVKaVUyWnVORmZsQ1A1?=
 =?utf-8?B?T3Znck44L0FFUzNsUnpoZkdORm5NUU1iQncvSThvS3pHQTJOby9wdFlFUjJi?=
 =?utf-8?B?VVY3SnRwa0laTW1RS09xbnQ2WHJ1NHp4TEZ1WWxieklMSEhMaUJRMldPU0lE?=
 =?utf-8?B?dGtOTGJoclJtbktJcjRmMFhROSt6Y2JsRFltUmVKTEZPTlRFWC9QcGlTNzR2?=
 =?utf-8?B?clI2cnZmOFFyWFJSWjV0aG9xMC9tM0lPcGNPdGlSSExjTGxSVHJBVTVSN09t?=
 =?utf-8?B?NEdaVHhUQUZOaytWeUwxNzZWbkh5NE85c0ZyZ3kvVWxZb3RseWRwVWlRRGJa?=
 =?utf-8?B?VmdISndxMjlyM3pWRU1iTjZMWFYrMStQaUh1TDFwdDQzaG9iVWxCV2Fndkpl?=
 =?utf-8?B?aitaMEtaQ0tJMVdvWjIyR3hrMWVmaWxjV21qRXdRVnpvZWJ0eHVxbkpHc2xR?=
 =?utf-8?B?VWQva2QxYWtDc3VHaDcxVjN2LzZaVnJKSXl4SDBzY2FyYUpndlFBUGs2d3U1?=
 =?utf-8?B?T0dMQ29aYkdtdUxrS0VzZWs5bG5XZTBPR3RHMnMyY0hiSG4zV1FWd0Q2Q1g2?=
 =?utf-8?B?cHlPNG81bEZ0dWFDdlZtVW00bENuWmhYcWhjdm94WEJ1YUgreG9kM2xtdkxi?=
 =?utf-8?B?RnZoanMvSDNsRmxsVFFJL2FPNVlLK2Q4RWZYRzhBclN5am1WT21iMXBRa3V1?=
 =?utf-8?B?cFUyTVFpN3J2L1VOV3ZFYmhxeXh3WldLSVVIN00rODNnQithcjl3YUI5eGFt?=
 =?utf-8?B?OHRtRUExbEVqbG9XMmdnUE9DK05jTkR3bWNvemRFNExQcjBvSGdPMkhGVG5h?=
 =?utf-8?B?NGpuVFhKUjhHU29HVFNuQU9LcXd0a09hSDNBMUNqZnlEK09YQlZUUE45TXBM?=
 =?utf-8?B?U3pjQUFMT1JCUGlqS0Q3c01kNE1UOWZUSkhuWGM0dVA0Z04zZmY3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52997b8-3fe0-475e-5a21-08de473d7bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 00:50:52.7989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFWbSjksjCsPtGBCjzCRJWn0BuuT5XoY/0xSTGg0/xEDCJSAyte28fa9HFGQ60/mYKL7vyN1VTkhSo7nQQVO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7798
X-Proofpoint-ORIG-GUID: fHBMz-dJmaxoIZzLa_SlAcYcBIv9DuyY
X-Authority-Analysis: v=2.4 cv=V4NwEOni c=1 sm=1 tr=0 ts=695321ef cx=c_pps
 a=QHQ/c+VJRs0sJIezHEQ2hg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=pr_VMrpBNiGrJJZQjssA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: fHBMz-dJmaxoIZzLa_SlAcYcBIv9DuyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDAwNSBTYWx0ZWRfX4mJFBtbUJBc8
 Jx8ODabKa84c6OQeTHHncebNaQldOn/zi6PC2izakw9D6aSSrkkVIv4M2PJrScPOy839dlga6ql
 tmkCLxS8+xazE74dsvbgNkR/Wdn5BTXaRk0GS/TW0FQc5SpYvz1t8LzKpqQCQjrEH54o9v3ile1
 99U2D6wzWYaiBqwzobvFuegYMAVWZyzKaUkQFs5GLZLXgI9/EFOlgZNjsL6Yz3+YRXmHZ1of+xU
 4jMVZ3tAhAddtSKxxrJBZUVfsd1kYq+1WskR9pa5jcXE3z0ejA+U5W7wkWsyJww5eB/nKUun1o0
 0+xJCYOtUD0eVIxEyKhev+yolmNd7AM9akEymvO1YT1SMsNgpNAgvt8gL6qC/JbYyNjwF4Khj5q
 ATezHa0Bc18drahp3XOHIL6KWQ5fltDpMBtJjqHCDyBNxk8ANHuxjTt6E6CrvRqrtMkwZIzrz/5
 FjNzKox015ambOg2hdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300005
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 00:51:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2881

SSdkIHN1Z2dlc3Qgd2Uga2VlcCB2ZXJzaW9uIGFzIDI1LjExLjAsIGFuZCBvbmx5IGNoYW5nZSB0
aGUgdGFnIHRvIGJlIDI1LjExLg0KSW4gdGhpcyB3YXksIFBFIGlzIG5vdCBuZWVkZWQgYW5kIHZl
cnNpb24gd2lsbCBub3QgZ28gYmFjay4NCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcg
PHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIEFudWog
TWl0dGFsIHZpYSBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQpTZW50OiBNb25kYXksIERlY2VtYmVy
IDI5LCAyMDI1IDY6MzIgUE0NClRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5v
cmcNClN1YmplY3Q6IFJlOiBbeW9jdG8tcGF0Y2hlc10gW1BBVENIXSBkcGRrOiByZW5hbWUgcmVj
aXBlIHRvIG1hdGNoIHRhZyBmb3JtYXQNCg0KU29ycnksIG5vdCBzdXJlIGhvdyBpdCB3YXMgbWlz
c2VkIGluIG15IHRlc3RpbmcuIFRoaXMgbWFrZXMgdGhlIHZlcnNpb24gZ28gYmFja3dhcmRzIHNv
IHBsZWFzZSBhZGQgUEU9MSBhcyB3ZWxsIG9yIHJlbW92ZSB0YWc9IHZhbGlkYXRpb24gZm9yIG5v
dyBhbmQgd2UgY2FuIGFkZCBpdCBiYWNrIGxhdGVyLg0KDQpUaGFua3MsDQoNCkFudWoNCg0KDQpP
biBNb24sIERlYyAyOSwgMjAyNSBhdCA1OjQw4oCvUE0gUnVpcWlhbmcgSGFvIHZpYSBsaXN0cy55
b2N0b3Byb2plY3Qub3JnIDxSdWlxaWFuZy5IYW89d2luZHJpdmVyLmNvbUBsaXN0cy55b2N0b3By
b2plY3Qub3JnPiB3cm90ZToNCj4NCj4gRnJvbTogUnVpcWlhbmcgSGFvIDxSdWlxaWFuZy5IYW9A
d2luZHJpdmVyLmNvbT4NCj4NCj4gUmVuYW1lIGRwZGtfMjUuMTEuMC5iYiB0byBkcGRrXzI1LjEx
LmJiIHRvIGFsaWduIHdpdGggdiR7UFZ9IHRhZyANCj4gZm9ybWF0IGFuZCBwcmV2ZW50IGZldGNo
IGZhaWx1cmVzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBSdWlxaWFuZyBIYW8gPFJ1aXFpYW5nLkhh
b0B3aW5kcml2ZXIuY29tPg0KPiAtLS0NCj4gIHJlY2lwZXMtZXh0ZW5kZWQvZHBkay97ZHBka18y
NS4xMS4wLmJiID0+IGRwZGtfMjUuMTEuYmJ9IHwgMA0KPiAgMSBmaWxlIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkgIHJlbmFtZSANCj4gcmVjaXBlcy1leHRlbmRlZC9k
cGRrL3tkcGRrXzI1LjExLjAuYmIgPT4gZHBka18yNS4xMS5iYn0gKDEwMCUpDQo+DQo+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWV4dGVuZGVkL2RwZGsvZHBka18yNS4xMS4wLmJiIA0KPiBiL3JlY2lw
ZXMtZXh0ZW5kZWQvZHBkay9kcGRrXzI1LjExLmJiDQo+IHNpbWlsYXJpdHkgaW5kZXggMTAwJQ0K
PiByZW5hbWUgZnJvbSByZWNpcGVzLWV4dGVuZGVkL2RwZGsvZHBka18yNS4xMS4wLmJiDQo+IHJl
bmFtZSB0byByZWNpcGVzLWV4dGVuZGVkL2RwZGsvZHBka18yNS4xMS5iYg0KPiAtLQ0KPiAyLjQ2
LjINCj4NCj4NCj4NCj4gDQo+DQo+DQoNCg0KLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCkxpbmtz
OiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KVmlldy9SZXBs
eSBPbmxpbmUgKCMyODgwKTogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8t
cGF0Y2hlcy9tZXNzYWdlLzI4ODANCk11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy55b2N0
b3Byb2plY3Qub3JnL210LzExNjk4MTk5NS83MzA0ODY1DQpHcm91cCBPd25lcjogeW9jdG8tcGF0
Y2hlcytvd25lckBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQpVbnN1YnNjcmliZTogaHR0cHM6Ly9s
aXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9sZWF2ZS8xMzE3NTk0Ny83MzA0
ODY1LzE4NDgwMDU2OTAveHl6enkgW1FpLkNoZW5AZW5nLndpbmRyaXZlci5jb21dDQotPS09LT0t
PS09LT0tPS09LT0tPS09LQ0KDQoNCg==

