Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A31EC021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 00:46:19 +0000 (UTC)
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
 by mx.groups.io with SMTP id smtpd.web11.11975.1739925973294303373
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Feb 2025 16:46:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=PNec1xcF;
 spf=pass (domain: fujitsu.com, ip: 68.232.151.214, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1739925972; x=1771461972;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=LvqNxwTBcWIH5++7R6XhpSs64ujP9nsHSSTXbFHbo+U=;
  b=PNec1xcFu+QoqSchCLufmYHWm8mbkkGEHpGXp6aV9gT9C5jakXnB/eb4
   vIOphe0t1HM8SaEXaPWuyYRd+/ySG4QIifKWgGSMqZkUIugG+b2w2TmQ/
   gS4Jb4JE8qW1Y72HsntbgEMJqwrnhSJjP5sWqsOdcv/IG7wkPXlIeHY0i
   5s6PSU3NmjUoScBIn1N0gZmG1LzH42PtOFYz5E3GtZkD/3h8tcIDEipKS
   rQSmUHWMsxIiW+Qyvd/0Y8D99XFCq7EwZPVZbueURlCMJWL7s9PPuWFhx
   YfpmPH84hGsG94HQulechVeb6xEPDn2kI3+sKUf4qUXi+5I9DmzNsjhMR
   w==;
X-CSE-ConnectionGUID: 5oqNoB1QSTmcNkl/d/NA6w==
X-CSE-MsgGUID: vo0poGKiRf2dwipAIS56dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="59800552"
X-IronPort-AV: E=Sophos;i="6.13,296,1732546800"; 
   d="scan'208";a="59800552"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:46:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlCb1rGBAhpQqtaqCx4ZbEkmZsgKhAdaE7LlqNjKdT9n63E2TsqNIM03nhF06NqBibtFvvS1aeYr17Za5KwHJamR7I1Ih7FC1Y0x2P3fQ/CuRO9dAfhUKDniVpPuQ9Dtg/ISja5uBUgl9s6JP6lRkFFKCKkgXmL6du+9kCvZnsXlevQFtgHtmBIAkfLo94mF4hun0Jf6BGvyD7VRrRqN75Hvyh35P0ATZ7zYyETKRk3A2L25nOryLOAvcoXRyLEtPtqp4pf1kpznuW6bvPdfMSWFkajy+XLMNET2sTrgZ3+nf9EuFilVI94BCR4ASAquKuMgKdjW2fw6qZYPzOnoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvqNxwTBcWIH5++7R6XhpSs64ujP9nsHSSTXbFHbo+U=;
 b=g5kW2Ip8MTfJAhpnY9kPyvm6GhIhV2zdzeyfUyiI42w4Y2hB6xFmWjVWCUsTc61x1pFKYfi7oywMx+e+8Pr3eWc98MkX8OeD0vxyXFEYCbxf5ACQcLoq7nLE29xG1Oj6ff2fZvIoCuQr0OSqF1HpWUdOyOmLbgeDkR4O2U8tBFxMpWLzHocm1m25+KjzkA03snAOyhnPayKejPI0ao3reYKd5SLcLSNCDBsyXo3NHKtGJHeI4sLNCTaqnCcOgD5ZeZintzRKxEfckTM8CZAD3bkcf8bMdefVycW8Ifn6nJDUmLqVqulTzK4/6/ThSh1VqyRfWZeiuReQ94ijIiP7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by OSOPR01MB12347.jpnprd01.prod.outlook.com
 (2603:1096:604:2d8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 00:46:07 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 00:46:07 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches] [meta-java] Issue of cacao
Thread-Topic: [yocto-patches] [meta-java] Issue of cacao
Thread-Index: AduCZ6VoCCyyKLONQkmHYtLFdNLtLw==
Date: Wed, 19 Feb 2025 00:46:07 +0000
Message-ID: 
 <TYWPR01MB118615E9B023329FEAEB33BB4DCC52@TYWPR01MB11861.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d7fe272c-3cf5-4f95-b736-49c8854e1eed;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-19T00:46:02Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|OSOPR01MB12347:EE_
x-ms-office365-filtering-correlation-id: 3c66c1cb-148a-4259-879f-08dd507ecbc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|27032699015|38070700018;
x-microsoft-antispam-message-info: 
 =?gb2312?B?bFgxWW56TTVUeUJIY21naHNUYUh0VWx1SDU0RTVPcXl0aGh1SXFyQWl2dmxR?=
 =?gb2312?B?RXMyME1qMTAzNUNha0RYemszZzFtdmlvTmJFaDBLbTdncHY1RWkyclhCSTlh?=
 =?gb2312?B?Z0ZndmU2S2NhVjFGaFU4bVExTlYrRDZxTXR2cWd4ZSt5Smk4SGM5dkpiaU5q?=
 =?gb2312?B?UzI0UTVWQmhycDhobXl1NkM2Q2swQUxmWnU2eGp5djJJbmdWaCszMWdLL3A0?=
 =?gb2312?B?cmFSbEp6MFhodlFoVyt2c2Z1SHBua1VlaTJFSWhXVVRNUUtTemNKbk85Mm1r?=
 =?gb2312?B?RWtRUnE5eUpnbWtXbStwck04bUFsa09XaERjOWQvd2RqbC9rMGIzTUhvMSti?=
 =?gb2312?B?Zzc5VmxzK1NTWklsMnhReTZlMnJMN1RqKzBQV3lIanl4SVB2K2o5N0tCdXBG?=
 =?gb2312?B?aUVZZkIyRGNNYnBaYWlheC95ZmFZVGFoa1VucnI0UCtPRzZ6WndtNFFib21C?=
 =?gb2312?B?RVZjK3poSjR0Skl1UU1UbW9kNkREV0pJSjNMM3JIa0dDemJRbDlJczRXaU0w?=
 =?gb2312?B?YWw3SlBKOER4bkVKc2ZCcFVQbWNIVm5meDlQWG92cDBHM0hiQ1A1Ykg4SW5N?=
 =?gb2312?B?WHRtYi9ndkJyMis1d1NyN1RVYXJHZU55OFlRZnJEZVZxQWFWcVV5Sm1nQVpx?=
 =?gb2312?B?ZDNWZnpaTGgxQWR0dnZBdUdnQkdVTEtxb2VvK25mRXgzeTYrZ1BuOTRZRHRE?=
 =?gb2312?B?YWFseDQ0MnNTa3JVQzRZL2hHYlY3cVpKUEZ2RExGTmFxK1EyZWRuNiswdnVP?=
 =?gb2312?B?ZVIrL2RxRmNsOHVnNEZsSnY5eTErVTk0UW5IR0dnOThlZVBLMTRMSGlmd0Q1?=
 =?gb2312?B?bWFTdVRBMGkyZnB6VDJVVnZaRm5lVjJGZUsyZmR2RUNYMkVEa2cwei9mZXdE?=
 =?gb2312?B?VkZKbXRkci9lN0NsV1JUdU5nQTlheitLYXJUd25RcllYbTZlQjRIMEdHTURE?=
 =?gb2312?B?d1FjVlB1a3pDS1hHSHJiSFhITEttWmFTZzhVS241SW1QSW0rZUhraDV2UzBr?=
 =?gb2312?B?VzBaOElTbXhiNGhFdkJGanR4bFYwQlNkRE1jREY2cEhlRk9WSUFBZjdrZndo?=
 =?gb2312?B?ZkQ4MFQwOVhoS2o2R2xyNVRkOXBPbHVJeVMzQlJudlpsWW5BT1RrTEFSSzFE?=
 =?gb2312?B?QmU5TFl1MUlPZmFNN2cxMXRvOFdjYzBJd1J6dGc5Y3hXelJaaWdpck54Vloy?=
 =?gb2312?B?T2ZpVU9GM2t3bldhL1JyejhTSGNNWnZGRmtTekxXeDFmVWNjOHFjT0JiSWIy?=
 =?gb2312?B?UHVveG9TZ2JLNXYrYzZPbUxpVDg4TFd4SUdVZlJlMFpLUEYweEJ3eUE4VmRK?=
 =?gb2312?B?RFV2VzNEOTUvbHBBN3BxTW5NaFVGT1JWVkVjYnFrcDlKTmlYdlRQaGZoZUlD?=
 =?gb2312?B?NXh1VUtwdjJESVBVazdEck82ZTh6ckV6NTM5RHFBREVXblZUTXFReE5NWWd2?=
 =?gb2312?B?bmo3MFZvZVZqWXZjQWVmU1hjc0x2RDRjWUNtb2EzRFk0cHJDYklDdlNWSVFD?=
 =?gb2312?B?NXNYcTVYR3VmdEd2d2wzVzJKYzg2TWRQK1k3eDZtbzZDVmRXOFBCR3l6OXI3?=
 =?gb2312?B?OWRqOC9BSm9rUERDaTRXb21pZ0ZkeVZWZjdUSmNPa1Rjd0w5QnY0SmpCRDJy?=
 =?gb2312?B?dEpRVll4eVg1OGIwNjU0WHQrelZrSWVrb1dlRWZQYkxyck44OVBwL0d3R1BR?=
 =?gb2312?B?THhDV0ZOMzlzcG94M3ZxaFpWYmZocEpjWC9oVERlTzhMMzl5eEUzS0dzTWkx?=
 =?gb2312?B?OTFYVFRGQTZ1b0hDNFR2cmE5bGMzakdOVm8zSktqQS9nbWlLdkV4RlZBTmtN?=
 =?gb2312?B?SnlFQ05BQkVVcmtua0ZmeFp6QVAvNVdCVVJoQnN0RUtQb2ZrYTRQNExlK095?=
 =?gb2312?B?MHNDZW5kSTliNGt2UllaczE1TEU3QWo2Y1k3d3c0WWdVTStYUVlBWnRZK3U3?=
 =?gb2312?B?bGNTWVh5M2loL2psOXZqTXAzbG1naTVlK0FZZFZWbi9nQzZNTWpCTmxiNU9p?=
 =?gb2312?Q?sFhD9fF2hqHvphSZYbgymQ9XxU4jUU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(27032699015)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?djlwQ3BuYktzVkN1eUM3YnVGd3pRbzBkYjFESkhKcElTREZUamJqQVlBRkRy?=
 =?gb2312?B?cVU3V08xOVkwSGJpNkNOdDBCOXd5Vnl5VW05V1JJZi9FZWdzczVrLy9qWEo2?=
 =?gb2312?B?L0lzd0FTT3lQRExjdmhqN0h5dU02YzFMSURUN0M5QUxtWTR4Z3VYd0FaT0JM?=
 =?gb2312?B?YkdVRkNGeXJ2Z1ZaMk05ZGJJNW9FLzRYVkZHMzcxNjFnV3ZtSEV6UU9sb3Vp?=
 =?gb2312?B?M0EvM3d5SjUrZWtZZWdsSGxWTnZmMnlqVVZGMkUrU1ZYc2NyTEFlTEt2Yk1z?=
 =?gb2312?B?aHV1b1Z0S3lEMzg3S21zcUdyTWtReFhJdzBJZ0todDQrMEZoZXltdG5sTUZx?=
 =?gb2312?B?YzZFcWtnaUN0dUY0OVFmTk9IT1AyZFdXMHVpWERBR0JLNjZWWnpySnhwWHdC?=
 =?gb2312?B?eWZqSXM4UG9qTndJZFVuWWpaVUx6aDVKaDlhZVRpTHN0WkpaWTNTYnY4aWpJ?=
 =?gb2312?B?Y2J3R1ZkMlNLMGVDaWRVR2x0RmpoZGFxVW5YcGNEdGdWeXZiMnNXQjkxSGhD?=
 =?gb2312?B?bWhGZG1CWEZwQ2JPVHFlS3ZHUFF2QUZwMmJPSGRscytaWm0rNFRZdEVGV0Zo?=
 =?gb2312?B?YjBMaFc5Yy8ydDNId1JZMFVKMU5ZOTVUU1N0WHlBQmx4cnFXMDZ6TnhzYzNL?=
 =?gb2312?B?S3p0YVdMOHJwTkN0SzhSZlMzRHAva2ZXRER4SnVhZjFFbEVtMlE4K01IcUg2?=
 =?gb2312?B?empRZXBpd1hwU1Z4MWxNcHZKZHJFc0hGd0crTjZSZkNMcXdDT2xJSzZIQy9S?=
 =?gb2312?B?SnZzelh3WEJ6MVExRW5CQk50ZlVvaHJzazIzd2R6U0IxTllENDFTRG42blI2?=
 =?gb2312?B?Vm5ZT0JiajhXbVgwaDBJTHpHRnNyMld1bHVkaDJ5Z2hERVBSTERVcEIrY1FL?=
 =?gb2312?B?eGJ1R3p0WnpOV1lJZkRNVmkrOUMzMUtEVCs4Yy9pT0NPQm5zMlFKajRkSGo4?=
 =?gb2312?B?N1h2M2M2NW5HWGtNV3lWTlZPUE5XczdSVGlWSkkrWjhBLy9tdnBtUFNYL3dR?=
 =?gb2312?B?U1ZPdEVyNkJSREt3ajlyek9VUzIvNTF6T3VSYnRDaEdRYThPUnlMamprK1NM?=
 =?gb2312?B?T3pYSGlmcTJqN2hsZUg4TnVFQW1WQWZOYU00VjBsRkxKQTc0cUNTU1VocFZ3?=
 =?gb2312?B?Wk9uWE93TytQS2FYeDJDN0lzS2dlN1ZTOFRKMkpnQ0lpUi93MDhJUUVrcFNT?=
 =?gb2312?B?NWRvK2ZScVo0OTMrUnN0cWVFMHQwSFh5M0FHUXlqN2pMdEowUzBvZy9kWXNX?=
 =?gb2312?B?NlpybHlaTTg3b0hBTU1yS3RWNktHc1lpNkUrUldHMVFHQ01aVUpocU1XTWV2?=
 =?gb2312?B?U29ITDUxSVU5d2U3Y3VwR1B5VUN5bzFKMlZKZFBEeURLZDd0YWxqUFo3YjM4?=
 =?gb2312?B?YkNidlFmT2ZHWitQS0p5aEQvL1NGVnJ1S3pFbWVpVTJNeVlxekgwRnRZazZG?=
 =?gb2312?B?Rldtd0NWSDk0V2Rldjdsc2trQjhteFlaMVFaVWRTL1pxTjlwYVpWbTlRN0Ur?=
 =?gb2312?B?TjFhS3NWTUFTQVhTNENhelNUMUNEbEtVM3N6dkZIelc4akx0djYwaGRKNDZJ?=
 =?gb2312?B?R3creE5xMEZVMm55SDFGRDNERDNKR0d1UWNMcHV0VVVLRUNLU2twTE5sZkVC?=
 =?gb2312?B?azU3dmcvN1NvS2lxeW4wa1ozbkZneDRTWGxRa05Dd1hxTlFUZ3NvViswVWFh?=
 =?gb2312?B?Mk9NTFpOYVExR0diWE5qRS9NQm9OSWhvaW94cHJnMDZWbmpmVUpHMlpxczBY?=
 =?gb2312?B?RVc5a1lla1IraU5oTVVTSGFQcUJld3E2aHJoK3c0LzlNT2RvWDFuc2NzU3RS?=
 =?gb2312?B?K1orcHFGbWJyWGcxeTViM1RvZ3puQ3hvaEtJTVNnMndMYzZJN0hRdG84VkhQ?=
 =?gb2312?B?dWJFaklPRmYrZUFCVlNncXpSV3YyZGMxTGdWQmlMZU5SNFp0aTRyMnRudFpZ?=
 =?gb2312?B?Z3NvTDN3b2FueVoyZmdKRFdrSEZFYmQvcVpqZkViV0lUeDlab3BGV3prTHJN?=
 =?gb2312?B?amlUeXZUMmZKR2tIbEdFNndQdHdnOVFzOFljL1ZCTWF2OFZ2V2hadHB2WWt1?=
 =?gb2312?B?dnNhM29EZnhpUkVaTEdnemhpNFZMeFZoOVpFd1FIUGVrSTlrTHhIOVFuaVlZ?=
 =?gb2312?Q?bNMw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	51m06NwVbolZmu+IwhYFWtw4cr24quSzmenlRzg8egi9ZyxBgAXhElco+9lTv01at+R523LQVfDa4M/CXu6VJtKZCiy4iyO78BKgvCoa5OZdgWTOMX41AJ4RJBH7dgtIf4C3t0eWL6YE/wWUHKxXYyQaiqwnNVbBmc6qNmNsiV4grSXtDipgmgmUV7+8yrpBRL7ub1EKBR8FNDWnGGa6YKzslTq5sxyu2MiEex1MBwf4uwXwzZKrAztKdQowSLydF7xhrHPP01MSuftpFDsFpmYs8lGmXH1uAD2vPzUH7Ix3GGQFGQc3Xdjk4Rtu4HvSghyDdrzAeLHuGOF33LH29OOLr0RkWE3KreEUzbrHBukUV9F0ybuDLLm909nBXWKWxAqOg/Y+C4V4EIQqYBpwbo588uEdrbMVkFWysZDir6KlpXGo2SYfC9ydO5P7XM7qzecn2fA3xXdrqPkhXrcEZDsBqrpPYOULoUSHDNhaW7GeO5jfF4fvQhjZLsYIiiSejAmUzMaBJQRh5R/BtEuVx3LMTudOk7O81jh6JMU4OMR98NBhn8k6p4wHi1dd7bz0LuowEjd1xupfg9pH/j80vpvDPBchBH2wEn+LsadilcC7WSDBtDCkqwMYLkYPtPnj
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c66c1cb-148a-4259-879f-08dd507ecbc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 00:46:07.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZO9lrcdN6jxwD1xQp18GAmUNCIOfoDvHCDmPOyCWUWztKz2pWIh2t2eeoUOpPyGZ0JoacwuUhJFbmlUY/tXIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12347
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 00:46:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1090

V2hlbiBleGVjdXRpbmcgdGhlIGNvbW1hbmQgYml0YmFrZSBvcGVuamRrLTgsIGNhY2FvIGVuY291
bnRlcmVkIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNCi91c3IvaW5jbHVkZS9jKysvMTMvYml0cy9z
dGxfbGlzdC5oOjIwMzE6Mzc6IGVycm9yOiBubyBtYXRjaCBmb3Igoa5vcGVyYXRvciE9oa8gKG9w
ZXJhbmQgdHlwZXMgYXJlIKGuc3RkOjpfX2N4eDExOjpfTGlzdF9iYXNlPGJyYW5jaF9sYWJlbF9y
ZWZfdCosIER1bXBNZW1vcnlBbGxvY2F0b3I8YnJhbmNoX2xhYmVsX3JlZl90Kj4gDQoNCjo6X05v
ZGVfYWxsb2NfdHlwZaGvIHtha2Egoa5zdGQ6OmFsbG9jYXRvcl90cmFpdHM8RHVtcE1lbW9yeUFs
bG9jYXRvcjxicmFuY2hfbGFiZWxfcmVmX3QqPiA+OjpyZWJpbmRfYWxsb2M8c3RkOjpfTGlzdF9u
b2RlPGJyYW5jaF9sYWJlbF9yZWZfdCo+ID6hr30gYW5kIKGuY29uc3Qgc3RkOjpfX2N4eDExOjpf
TGlzdF9iYXNlPGJyDQphbmNoX2xhYmVsX3JlZl90KiwgRHVtcE1lbW9yeUFsbG9jYXRvcjxicmFu
Y2hfbGFiZWxfcmVmX3QqPiA+OjpfTm9kZV9hbGxvY190eXBloa8ge2FrYSChrnN0ZDo6YWxsb2Nh
dG9yX3RyYWl0czxEdW1wTWVtb3J5QWxsb2NhdG9yPGJyYW5jaF9sYWJlbF9yZWZfdCo+ID46OnJl
YmluZF9hbGxvYzxzdGQ6Ol9MaXN0X25vZGU8YnJhDQpuY2hfbGFiZWxfcmVmX3QqPiA+oa99KQ0K
DQpUaGlzIGlzc3VlIG9jY3VycmVkIGFmdGVyIHVwZ3JhZGluZyB0aGUgY29tcGlsYXRpb24gZW52
aXJvbm1lbnQgdG8gVWJ1bnR1IDI0LjA0Lg0KVGhlIHVwc3RyZWFtIG9mIGNhY2FvIGhhcyBub3Qg
YmVlbiBtYWludGFpbmVkIGZvciBhIGxvbmcgdGltZSAodGhlIGxhc3QgdGltZSB3YXMgaW4gMjAy
MCkuDQpBcmUgdGhlcmUgYW55IHBsYW5zIHRvIG1ha2UgbW9kaWZpY2F0aW9ucyB0byBjYWNhbyB0
aGF0IGFyZSBjb21wYXRpYmxlIHdpdGggVWJ1bnR1IDI0LjA0IGluIHRoZSBmdXR1cmU/DQoNCiAg
LS0NCkJlc3QgUmVnYXJkcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpXYW5nIE1pbmd5dQ0KRlVKSVRTVSBOQU5KSU5HIFNPRlRXQVJFIFRFQ0hO
T0xPR1kgQ08uLCBMVEQuIChGTlNUKQ0KTm8uNiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEy
LCBDaGluYQ0KVEVMo7orODYrMjUtODY2MzA1NjYtLTg1NjgNCkNPSU5TOiA3OTk4ODU0OA0KRkFY
OiArODYrMjUtODMzMTc2ODUNCk1BSUw6IHdhbmdteUBmdWppdHN1LmNvbQ0KDQo=

