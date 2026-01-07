Return-Path: <stephan.wurm@a-eberle.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20B6CFD632
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:38:25 +0000 (UTC)
Received: from mx-relay98-hz2-if1.hornetsecurity.com (mx-relay98-hz2-if1.hornetsecurity.com [94.100.137.108])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6007.1767793102578895053
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 05:38:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup selector1-aeberlede-onmicrosoft-com._domainkey.aeberlede.onmicrosoft.com on 127.0.0.53:53: no such host" header.i=@aeberlede.onmicrosoft.com header.s=selector1-aeberlede-onmicrosoft-com header.b=XD+IZVuR;
 dkim=pass header.i=@a-eberle.de header.s=hse1 header.b=VRrVYHZW;
 spf=pass (domain: a-eberle.de, ip: 94.100.137.108, mailfrom: prvs=04600f3958=stephan.wurm@a-eberle.de)
ARC-Authentication-Results: i=2; mx-gate98-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.69.114, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=am0pr83cu005.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=7PsW9u9Qw+kUEUg/ZiO86r8SWx46Bhj55sf42at8He8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1767793099;
 b=MydsV/Fxb3SXYfJQkHSXvaB+wSUTFi7eNkLUV6FmAGHR0Bwubff3oFJ/CcJA7SSTII4w9j/R
 SXqw+DLb01HE0wOqpAzxXBj1A1N+O/zY+apW3VcSXN5kpQaBFtwtYqXJDo30t/taV7AwkY/RC/S
 pilsCSFejWB+HPfSDnvu+iqInM07RVN/qKSDMyqwOymdgIqEgcc0sNAyof8NYsHp6upsgCRa/Hk
 rumSy2gt80locrq/VMm0uvNz1A8/8fp4q8lwfGGoEfi5wQBuPTMnITOct2oeouDOnpbH3oUUzLv
 /f91De3Nd4WKj8xMUVmnNA4B6eypkO0Q+VPWWkQk6y77g==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1767793099;
 b=ahHvPtidiUafmTenR5l9rPbN+lniiuMyn47V0pycCPyE5x2tXcNb97iMn/oRPTF6QI1XtEOk
 pJ6EL+Q247Jf+3QEFzIhpQ1t6/IMKZzv8ntiPt2Nh/yAg6EJtMjLczrflGxb6J85NGH2Zgzd+ty
 mwZw6Bw/KllLkrHaOtGtM30tE/0PQnUpxdpaQelbSLkDzuYLdGc1M9sULYaEbz2UOD1nKFFl2PQ
 g5DoTJg88SDF5FrkCFSvQ1FQdqbm2MSefeqLFb64mPURReaHvr8OKiRqDLkEe7w8NRwqqBX34q+
 a37OIGJYuPhRB0ehHMpgaSYkJCBb60KPOVCl/WVbunEmA==
Received: from mail-westeuropeazon11020114.outbound.protection.outlook.com ([52.101.69.114]) by mx-relay98-hz2.antispameurope.com;
 Wed, 07 Jan 2026 14:38:19 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiRD/aBVBQzAybs4Gf+6G1dinVKkeBppVCH+MG3jyyDXAheGFM6Uqxb7LxPV+qIEvwvTd8790CKvZYrL7Wa1FtOKK4FkIvSMr14SYI8iWF+S5FSKtCcEm0QdZWe5HR1C3d5mJg9KSTG3WnPB6x+nj+J69seqZi27dZgnm7LymLWdG7+dsSHwnakms1HWZQenS5e35U8gV/vDPxqMqkYx3zj8YGqHyOw6UUUoFsXSWFvpWhvD4GsCuQsGvFrScK3PloddgiY1TAfgAteYx/2KEbIPWi5/oEmJPBMPFD+Lv235gZcoGJh+lz0splXZYnNCeQ5L5wIBPrQd/N4YdrF1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PsW9u9Qw+kUEUg/ZiO86r8SWx46Bhj55sf42at8He8=;
 b=L3BBYGXjiJz4iG9sG1/vtil9tYxk1jDRss7eAjM0unPKMU/UtmrDD5omN4lNviUAI1YmlbhZq238JoofmuJTStvwrgISik7W0DTJdqhI46WAgRvzoM+dd2t9dk5PrKqQ1J+xKby9UivvgxAsuoMtd3XOE6/5dLTLVIJ0Pl3z+wx7NrA9wYRj0cd1NaIjiVSj8BUvSSQdAIN6Vhz4I6HpPS8o4MVQ1SO+vGgAqhgV2gykWmW6zvEDaPYlLLN8DIl0I7qD83KIVvJZRknbQ0SSYVJQeuZBxiE6ivF3HUXm9v+4IFZxHsL+rL8s853HGiLfpTSvgcxISLKBUJZexBEOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PsW9u9Qw+kUEUg/ZiO86r8SWx46Bhj55sf42at8He8=;
 b=XD+IZVuRIzPY171F/zm+Zc4Xendxe5kzsEuijkYFwrpeVh5sP/tFbdaRfOaSnMAscMbcRAEExL7aoHMz1Pz/fdVrsNDpSxHn+Z9Ek4vdgtusdb2NRkwTQglJeZB86aTEpVBOCWpKc4nAVJFuscTSWbE06y5NzN7LOFfh3XGzTNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:131::19)
 by AS8PR10MB7349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:617::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 13:38:10 +0000
Received: from DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::db8:52c6:f1a7:101e]) by DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::db8:52c6:f1a7:101e%6]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 13:38:10 +0000
From: Stephan Wurm <stephan.wurm@a-eberle.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: [meta-security][PATCH] dm-verity-img.bbclass: filter units from value part
Date: Wed,  7 Jan 2026 14:37:34 +0100
Message-ID: <20260107133734.1927398-1-stephan.wurm@a-eberle.de>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::20) To DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:131::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3674:EE_|AS8PR10MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: add01115-8c4c-4f91-dece-08de4df1ff4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qVu6NIrDQjWu/1HTIc4N6WcKDLuzzM7cuBGiDaMo/mWi+RVxOxToa7y6byk5?=
 =?us-ascii?Q?25MWFE7AkUvuPWq6s0EnJbEiS/T5LJMY4T4ZBn4uiJNOt1nCMA/JDSzl/gkk?=
 =?us-ascii?Q?pBLxzYy9riCv/NAKLonla76ZR8TAX5i6knd5kmMx7rMNj6rYpsqn2QfnShJB?=
 =?us-ascii?Q?7e2tNvoi6X1VQcLmKwFf643lpUmNnm6RpaNUvqyhuynjpj2R+qv6Ml9KrG9P?=
 =?us-ascii?Q?ocLrEsJSXIn4b5ZfYd4uGs7nnHdxBDj3qWJmBQrnSF3S4QT7PxLdQbor3qxA?=
 =?us-ascii?Q?N5xg5XQIsj/uGuNETmaZ+quKrfZ2ERCUT2Zw8rQ50fVWKlp7SyxAGj+sX+7V?=
 =?us-ascii?Q?705WaJsiLPTd5EOQN12vNTYg8F8csl8vSs5caItWxp9Qqo2PqUhLFK+NT5CT?=
 =?us-ascii?Q?S9sdBUdkHCxUU6RsQZKcTFncS19ejaSASuFZyrio1JnV9wXx2keQtPbfFN8/?=
 =?us-ascii?Q?LwDEZM6Uk/6Rzp87oMbJkXF6fLcPIDpDqXQBfHNeeg/dDXOvNbrbvPv3iqFl?=
 =?us-ascii?Q?KES33Ju7CGxHX9SzlFlK10+e9/hFLChcGhkfX6oGWFz3dgUBVMKJ5/ARFmVu?=
 =?us-ascii?Q?fNxtNRVLzxK1/5mB21i+elqIOFYGjzCjZEqf31qlKjGNnffjNxUz8riCiE/2?=
 =?us-ascii?Q?XB/xRo71Dp5aoK3h1nnkZmsmJbpSXSid8MsqVXod3JjrdqxbGxuqbftaO+nj?=
 =?us-ascii?Q?WAWY2y3aZtTUjIf9ox/0vOqMTJlcU099P5hk2DHuqn0sVzcNSE1b3f8yq8S9?=
 =?us-ascii?Q?7mmMArttlGNqlffQKOgirRYzXWPjmlrzTKVVYP3wHuLY07WfdI4x81y9rdxg?=
 =?us-ascii?Q?gcSWSdt2iHYDZPJcPJzXAMwhVpl7cdRhmd7ayDQAWJ1wkmZCEVrM0iLj/n4A?=
 =?us-ascii?Q?xODYkJExFeS/6OuQyFrkojl9W9+aSqFEdhiPKVqcs2KE7Zqo//Pn9FvJUT0l?=
 =?us-ascii?Q?4SWrL9c2NziosuZ14NxrrjcQdVvp6Nyo7mXN+bbPcW10iLfZD1l6t3YEP7IO?=
 =?us-ascii?Q?auRffJ2SxuGixQTMtp1iakwly0st7DY5Y0+ThsRX6qC1q8w0sNRVeM9cTrj3?=
 =?us-ascii?Q?yb2XxkGD1VnsQM49Coi+x7NzmogTol7glRKoXxAp5/za5QbgsgmzkPNxH/K3?=
 =?us-ascii?Q?hD8zLwVR9Oo2ENc3HWUPRYQVGjNNk2e6i4wbebYRU+8D3GEOgdApWKwFOSSa?=
 =?us-ascii?Q?nj9VOatJHfjakZaBeF4ZRPYqEmS5NWORGD2Ikju3JspXWmSVfj1oxV2wiSFC?=
 =?us-ascii?Q?feuf9Pv16jefPWVYKvfJv0zi8Xe6IijpAV7H+edAZCjkzXBLpxjpRHGgukx8?=
 =?us-ascii?Q?BZl9TRpAwjvCpIx19tH2JSn7O653t2NN+QEsUs2UhmS9gnmOWuZD5wMBwMAy?=
 =?us-ascii?Q?ort+/TARyoJJA6pRCGyVhve5Q0wrIOufk1TJo6XgcDPTwO7mx/RpCGOByS94?=
 =?us-ascii?Q?HyzAJbyP8NaWHh30Ah0L5zwTj/aMzP9b?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iPbP3MJy3jZtBVdhG62sACvX+wD8g8jJ4IARxpvzF+2jcZeqLOOXJ5JgMZ1v?=
 =?us-ascii?Q?2isDxh8qxr5epQf1Kin1nmQdr8JNEkkIBF6jN6y827vmgKRmCIyTUj2fOiMa?=
 =?us-ascii?Q?Y1oTTJcZD7jiWuQvm27VMteq4rv6b0N+NQ0IyDNvB3jG5ywcPq4Fk0OdVbuP?=
 =?us-ascii?Q?c/SiRDYiR909dE9May3kJwFlr1/IoytsajR7UpWwYZFsePlWqYXTltypjt4J?=
 =?us-ascii?Q?HW31FT3VVoEEBtd1fKlA4GsjK8DsKTyAzb+mKDHf3i+wkLzrDYZOt84bHjTV?=
 =?us-ascii?Q?TArVv7bDIxFATPAxynzurxa90LHMn1T4DRCuIcy3SNpeo5l7fwBmWYZttrf+?=
 =?us-ascii?Q?SjrVKEM31PxvUPK1ZqBptLoJv+io12HpWZyabdgI13gA49GpqhAOeZoPR0kT?=
 =?us-ascii?Q?y1bNUO0cXulGOhHRJYaBhRP8o4cmicQveKEhGdUEZ1MsK+6CThI6m2peuqzF?=
 =?us-ascii?Q?lfw3WNvRsoebJtCvwtVmzzYzepLUbt9h8jKhdVrYymYpCFFU25EIzaDnZT/H?=
 =?us-ascii?Q?tQZpLYRfQ0rn890V4UFhXBmOTNqNSHKRhFOFRv0v5kt+cDDN2qT6UrLzyGq+?=
 =?us-ascii?Q?BR7sFAhNsJ37rgllirthd2BOzFhCBsOoMVodLqk/TSUd+lSk9uEbEcB1xOfO?=
 =?us-ascii?Q?YJJ0m3gVCjXGjQlq/u/iGB6RZcNb4ATgIki6YKu2AX0EQ44+XRors7bvxGon?=
 =?us-ascii?Q?Z+LqyhQy2kby2ZCTti3IBCic1SGVJ0ukkw+rAgb/V+Q47tn9vsQuG3ZR0WOK?=
 =?us-ascii?Q?FELy8kVh9XE7t2mNFofWYV8aBYT1SgxXkEIodgToZEB1kICdzZY/EMMzEopB?=
 =?us-ascii?Q?HiBBAlWaTCoKeZtG77/DUzhp4Ph1hXyOtbsKLK8D6Y3ARKMVSnr+HQFXSSMA?=
 =?us-ascii?Q?/NH0tKJocgTLcOkwkYCtIfZm7qsrREpKrYAvwqmC3Srs9HGXRTJfSH70v7lb?=
 =?us-ascii?Q?2auaVH2QDxe7H+UVgAxD5ZsTUjT+F5DAgydAaIzdqSA8ITwmj3fwnuh3a7Ff?=
 =?us-ascii?Q?H1XJAKG5+hip4rqn4yCjqozPnJvRTvZaKTV7Z+yNIZwtEzhXqjSVrk6X2307?=
 =?us-ascii?Q?RvrDE/LE20F+JwI7h5gbxbrMxyWAtUJYC3NylcZMD6BROIczzkSmhGibPMfe?=
 =?us-ascii?Q?5YZ1OZiXLoeR4bFizwyRy8LOJwyKS9t0rXjzVbPnHcA9jsPOtbQfm1oyciA3?=
 =?us-ascii?Q?dw7eRODKlZvDQ+o1+xQVmR/0Vw/Ok1WJumw6lkIjBGBGhVXXTyg2c5pF7Qz4?=
 =?us-ascii?Q?Nh0zXNqeHIsXEeq0b/IPEXX3ksZFL3CXPGjWG+UGMhLM4EbVIJEb4b6vMc5I?=
 =?us-ascii?Q?whaP5YRBlDhkmTqDWkIr5EYnJcmaSb0deP9jt2rbSNkBNqZpGJbrzhFAt1qM?=
 =?us-ascii?Q?ti3VxjyTWSnCI59WmzSk/xVf8MRwSgJVzN6HcY/FDMOzxVs27UbNSJqpG4Cy?=
 =?us-ascii?Q?BU7fsx6WYl3A6N41Ao6UXNpYRDP4sk4MifDD6ix+gPdX+BwbXra2eD3mQNGC?=
 =?us-ascii?Q?6pEOAa7QagWd2zjik4dh7Avl1ihH7juUyAJFrE2CV13QR6MOA5EqfmMo8N1c?=
 =?us-ascii?Q?yMmJbOPSiW9VYdPEiix6qOe2F+jCB94GVCxB8d2yq1Aej4hFbSYcY0eWmW9a?=
 =?us-ascii?Q?bjLe/zHQ/ow5uIPA4mGkrRPDa7U2xoyTC9skp8NjkF01enTsbX+Q6NJCYaTg?=
 =?us-ascii?Q?d4wqiLPe0A7bHm8RtyE7+rX723rQKNiv5DJ6aiHliXfT+p6AWdm4ybcSb2lu?=
 =?us-ascii?Q?uOhUJxZaX5Fd7fe+S/WjgsPkDqZ59auZXQZ9Q+yl+IFyorKJlf3ztjjsSjaQ?=
X-MS-Exchange-AntiSpam-MessageData-1: RKwdIHTRyg1xFa+JZVyVKwjEwX6kIqDTV8o=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: add01115-8c4c-4f91-dece-08de4df1ff4a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3674.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 13:38:10.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +caMHwmkcvpNbRZl4jcJOdd9QGCIUP6Cv80gUilIpvbTbISS9harcyJmWpJukyT8sAMyzI0qMsxUTlKjLheHtKw2XpFdGburw8a9cPKxZ1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7349
X-cloud-security-sender: stephan.wurm@a-eberle.de
X-cloud-security-recipient: yocto-patches@lists.yoctoproject.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: stephan.wurm@a-eberle.de
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay98-hz2.antispameurope.com with 4dmTd10GX6zJRs8
X-cloud-security-connect: mail-westeuropeazon11020114.outbound.protection.outlook.com[52.101.69.114], TLS=1, IP=52.101.69.114
X-cloud-security-Digest: 46da4e2e8e4deaeaeed50cb9368b1d5f
X-cloud-security: scantime:1.581
DKIM-Signature: a=rsa-sha256;
 bh=7PsW9u9Qw+kUEUg/ZiO86r8SWx46Bhj55sf42at8He8=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1767793099; v=1;
 b=VRrVYHZW6BOODLdcewkb61/Xfmgo8bYtU3wgKZYj1lvWbupYQBVpoYy3EIwz857uoxxk/or2
 Vdbxnsbf/4JqXVhINKS/TR2KdO0pTFJ9K0O1dsuZb0Pz9z8vZaN5GZ8EHYta3WkpEDGXsHQ8O2D
 yPcOOAT2HYfQZzAQbvzNs+Bxwza2TRFVCWKG47gQCiMw6QPTD00BqeptqKlkawlrA3LXJSep7rv
 H4UJy5Rrtoj4Avh8s4epfLP7ic6I/qT4iWr4aMQfIcCc9EQf3dFxZCpudQUZwReYDEHugbiuWRq
 kjML3g2Tb4Y1MoZbiE2ho9OHoVm2icwIJ/iSCDZCiQr0Q==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 13:38:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2906

This is necessary for cryptsetup starting from v2.8.0 which introduced
"[units]" in its output breaking the parsing of veritysetup output.

VERITY header information for image-poky-20250701085433.squashfs-zst.verity.
UUID:                   5dc16c55-79b8-4988-9d79-900f8e143f98
Hash type:              1
Data blocks:            40091
Data block size:        4096 [bytes]
Hash blocks:            318
Hash block size:        4096 [bytes]
Hash algorithm:         sha256
Salt:                   f670bf67a32f4f5a22e052d7bf84830f8d35ea24e2d52f585f6275207899153b
Root hash:              a7eab55b7933e347650671611e4b2a10571f2a28a1fb0fc8eae409f7a0d86693

This extends the value filter to remove the "[units]" from the .env file,
while retaining compatibility to older cryptsetup releases.

Signed-off-by: Stephan Wurm <stephan.wurm@a-eberle.de>
---
 classes/dm-verity-img.bbclass | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 47f698c..48557e9 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -71,12 +71,12 @@ process_verity() {
     # two parts into separate variables and process them separately. For the
     # key part: convert the names to upper case and replace spaces with
     # underscores to create correct shell variable names. For the value part:
-    # just trim all white-spaces.
+    # just trim all white-spaces and remove units.
     IFS=":"
     while read KEY VAL; do
         printf '%s=%s\n' \
             "$(echo "$KEY" | tr '[:lower:]' '[:upper:]' | sed 's/ /_/g')" \
-            "$(echo "$VAL" | tr -d ' \t')" >> $ENV
+            "$(echo "$VAL" | tr -d ' \t' | sed 's/\[.*\]//')" >> $ENV
     done
 
     # Add partition size
-- 
2.43.0


