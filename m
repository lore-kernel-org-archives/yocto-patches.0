Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05CDD25049
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 08:15:01 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28817.1768205692231575982
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Jan 2026 00:14:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LxiFn9ZU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5472523fd3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C4ex5x2053047
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 08:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=QsumulUwhtKFll6TeZIoKzaelHaOsoIssxo4/PKp2bQ=; b=LxiFn9ZU/Jpd
	uls1823w09kjCoRY77QhFjsDIYghS+dAI1srO9OTthINFYZn8u8f97upqeaVqTzB
	3SH4lOqTgqd5HZ2OAdNe8XZXUcGPj4ZCWSImBpBxt78asj68E6jn5WcdU4Iw62gv
	K+ZKiuAt0je9372yrPENspYO1BrhlxxuLSqXIVdfXeWKv3GmpawQyBgvxs6+O57V
	UNfPtqiBa3JkgSeoPQCmHRP9zMDzpdbkO2LvdIeb+Nv+UJQ2TiE5vtU7Tb5DuZ+i
	zmZl5n35/6TOTpldN2t14pvXr10CV+Y1P/lP1AJxxicziWXK64eIJofcA28U92F9
	XERLThe1oQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bkdr2hgp8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 08:14:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP488HloXyXiTPAoTTSd3zXyhNVZ8co2JvQA2v51cpATE3e+9H1eaM/dBMoQkWryK1SBlY0wcxl2uQL0B9B2yRBPh9KKhYGJwDeC0bL0pEK5dcZP+GgpNrS4i6Z6+yrsxTIxoEyKYUo2vcRV+vIv7nnFeIOj/HOYY/Kkuh0keGoTe/muTpDkUz+1j1Tl0xgTl+4R/KHPp3K+B9xHoISngU+SQCjTb0u72vhi5BdhopPhPdIz6U1D/2PKvDEVvIba6qqGrARv34r2SZOuLN6uQyVUwsLCSCmgK8Q5l14BO//71tXjwmrs6VyG27SXi1osiIBh4m5HKcKVDW6TysqwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsumulUwhtKFll6TeZIoKzaelHaOsoIssxo4/PKp2bQ=;
 b=vgU89sWv6efocjmHP5HObPz7oQ1if82OTswDtznq631tXwVkQ3j816nBymMhv6BPNr9KnAwnpkg6kbVpvAxtZ84vzwztGDJEuRlcPG2xEQMFd5Cz/0956yZxvoI4f8c1N0se0qB2oANAayNL0kkdOrqxE7WgkINfT4IK3W1s8O0YjivRA0LF/+deMm07VEo7AmoCnXGFSMsmIbPe6by3+Burd0TgNtqOOXJYlybKpTN9jLj8rz9N+8U7JdhNqyIXde746FfIyCIUc426RtpfHrV9CRhWTN4mYl6ZxRVNBqUyQXmm2l1gZuNY35XDH40DQFo8xtWAzA57FLjWxQRYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:14:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:14:49 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [mea-selinux][PATCH 2/2] selinux-python: fix build with pip 25.3
Date: Mon, 12 Jan 2026 16:14:33 +0800
Message-Id: <20260112081433.2138945-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112081433.2138945-1-yi.zhao@windriver.com>
References: <20260112081433.2138945-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::11) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d5a927-45f1-4c2e-cafe-08de51b2a7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZfsMnVNK6fTvGMpt6HKD3gUXxzDrST19ITDXRRN//inQzdrZ/164Qhxi2bj6?=
 =?us-ascii?Q?ba+swUoRfvZMpO+HWOy9wFIy8gkOdcGE3jtOE6pu973IPTpXgYmRGtya8fcM?=
 =?us-ascii?Q?gmuRabZBlX0BtYgA14wKg4TbNf5Sd8lhsY1Figmri0dRI6NMg6irlWJjw+AP?=
 =?us-ascii?Q?O+IRtW0TH3PGsvArhG+e0aZ01CIVzv5WLCGjRFe4vEVtIPOiqyQLehsh4KxK?=
 =?us-ascii?Q?LfjIz7LgMF4SVFbkr5ZMHj5rpUNc/Cn/WpyAIPuF8ATLHYgE6sl8yo6wGkLe?=
 =?us-ascii?Q?M3Lt7AoDACTvUX8G7huFF0/AdTvT4jTTAkPI8JXNhLMXYcvNTd1/RPzsh8u/?=
 =?us-ascii?Q?76+afeIdhx3na4tgCqHY4tytNWtKkiK5sguAhC6HRT4Iq2A4lCQzSgZHI64Y?=
 =?us-ascii?Q?d5Mnl83TbesMK0gSJYEEkbI3d1C8NzWgjdoWXc6JGL++B6C58/qvAyhCoxPE?=
 =?us-ascii?Q?fclczwKYBun755SZLww1hAAbXLWX0JHXfffQImveZC/fNGP91WNF6ZeKxk9O?=
 =?us-ascii?Q?k/Imd7+F8NZuDOnjiu9rJuCa1uWHMjpNy0OA5CF8jmrbNvuGGbZNt89JaTcS?=
 =?us-ascii?Q?Aat1pwupA8kxEUA1YPkgF4cXOtWICP1WkniT7+sPIjciyWyV99vqiNMb12vn?=
 =?us-ascii?Q?ut22EVGCxWW6yltB3xiPmW5jDZoFwSaRak8C1npGI0L/vH3DQ0EY7dh2bymq?=
 =?us-ascii?Q?i8pMDafUu0NMZLlvP5XWOeKWOOgihDiatNUhslpU398CVvTTVzSnLUSniKK+?=
 =?us-ascii?Q?CuDhdFP/R8kO3fpWi/ViGMNQ6F/caSRVe9W/Gql9EbOfsR1WaV9eodXBmk4O?=
 =?us-ascii?Q?2AFnKceXU65pp2xekqUAT3jP3P1Et5EfTbzdBDrKl92onifd2Q7nokqb7I2Z?=
 =?us-ascii?Q?JJqT6MW0ke0/mJGGg1TvkRhfpDwT0fVCAi2wauFI3KJlNrxzmUaXTz+bO8Qg?=
 =?us-ascii?Q?Z5oRlLkwIhecdp3mXUNb2ivIRZoPeRwkCrhrKTqesNx7a8L5m8EXFYoKpkDt?=
 =?us-ascii?Q?8lmuKAckWmHq6LMNMwMgY18B8mka8mUJmx9Fxgf5jfjz7ImnQJzdZMan/O6/?=
 =?us-ascii?Q?Uqyxq94ygIOueLMoRIFiPFTKDXYCv4trA4VPqM1EmQqJ+E4vJLYabA8sdJLr?=
 =?us-ascii?Q?XFrkZuzDMLLl9kBrt0VZDsUhRqIfZRhQL6aUU+YyGhRn/CgII/v4/SJe450C?=
 =?us-ascii?Q?yX5FFiq4lNfUyPIethyJafSi5Rd26Q0ZYRJBeg6SDXjKhWJ2qS5iba3iFVxq?=
 =?us-ascii?Q?ppbt5XNTTbkDpyOnTttZY34ViitxsJfq7px+o+3d8DazNOFHnWrCziy9hZ/D?=
 =?us-ascii?Q?F25uUjQBZEq9tHZ83ZSfKfM0oWJenjBULdTraW9NYsZRW62RVtZ9Mdi/G+EX?=
 =?us-ascii?Q?VGeDWKgsGpX7dpQUnm0mDB8210jkcnNEIGhBViV5FZ4V4gQsGeDFN4NX88GE?=
 =?us-ascii?Q?2OR68u/5BYRNVlb6XR0v6k9lySZO3Leu7/NYvBeWaqghrDmI3+MzGXIU0T2i?=
 =?us-ascii?Q?cFP9o2YUkKgLWPNnqIkn4E6oVincc7iub0LA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ILp3nLsr0jt/yclGq5QUU3ZECim7lwVWyaB6Br6LsMcmfi82hPhMIfXF/8Or?=
 =?us-ascii?Q?3hjT6jK0v+J7Kf6Ju0EegspvoVtqAxP/fEz7d0nx1OOP2UukOMyVhu818i2e?=
 =?us-ascii?Q?EgXzLHiCluMJcle/lir4QSdmCMsOrXI0nozUaV4MfCK+vtruwUIyp002wJ6y?=
 =?us-ascii?Q?lj8c/aFy1qkmvUHYFHGBGYUz7iKakJr9Z7MXmqMskx30sB+x57QIe1BY/l7q?=
 =?us-ascii?Q?u0iY+xeqh9AomW1NrtdriFGH5NT2fUIJ1QhJRwDMhMw6Yp0zyTFicH8iUh9X?=
 =?us-ascii?Q?z4YzzdAwDSQaOsTrAjsGgtpWXADQGNQOHWZ2JAHkXxgrv7MNUsjSS3DDbi02?=
 =?us-ascii?Q?Tg4HCGlKkaLg40vOZ1AbZfZ83vn1kPc20SyQ7cEh/SHNPrxIldOXqXzXFLTq?=
 =?us-ascii?Q?2zFfW+d+1ecxg9wIGC3p4P8o8Z8FLcYjW7F3ZL7me2u19Gc2kSaKh+wYOmEn?=
 =?us-ascii?Q?4C8caOj/NQAOX+3P8fEWPno7uHDMzT9VftgkASn5IdEcgpIDgq5l8t7J/Wkz?=
 =?us-ascii?Q?aLzLajEqwXmg/23HEDR62c1d1KJQu7a79e4RP/vKHz0tNsl/ZLdbS8tXjr1+?=
 =?us-ascii?Q?hIHPHN3vj2IeroF4voBm0OqkmXWAwURHB9I/FGtxe1LjKh0cIWg16OeRuYrj?=
 =?us-ascii?Q?YlOaIrvm+iP/poNj4jKb8IkCLk9KxmpqoYhtUfMryS7V7spb/WZ0IgSGss9o?=
 =?us-ascii?Q?zG9N5VdDRcmvycBQljAmbcM+QZQcmBwAVVRaTvvlmEVTULdi1xmsGrRJSWys?=
 =?us-ascii?Q?SjDpRX07MOtwAf6jEeX0e7GE74LbfPnAsvdqEzrBqPcBZ5HLXOUfaXMHKDtA?=
 =?us-ascii?Q?YcgvaW2WFmHuEMIcNyEwpKCEZ64vx8kRcxRH58NTt8wYvV6+avMrhPIYrNrS?=
 =?us-ascii?Q?M9bPiRkFL9mT9BJBm+X/tOC2fEt8HFtTOte4hNFZSJ5kgznIwmAiCAH3Na4a?=
 =?us-ascii?Q?cPWmLrgFQ8UTrarj54/mgrUBFhMpH1bR2drKKKTjniKFlb2evimF5g6xVDoa?=
 =?us-ascii?Q?PIKDiOk+rkeJJGJedP4q4NFL6hFWs5UInYU99OJCV8CLCZXSoZGOZYF5xuFt?=
 =?us-ascii?Q?QdeiMX/jCvJBTPY2qAbDAGq25iu27sBGJgVD2DjHD8Zjl4GZzsXwWQOsyc0h?=
 =?us-ascii?Q?ijTuat51pPfGZTQ+1yiWyaHgGwjRfrtXbGPnEP3Y3J4sEXWL85RYzkrAkpke?=
 =?us-ascii?Q?WNM7RJu25m8DIozPxaZvX+EbYpGXwUxf0ZbGGo1pLqAOK3KWnuoVyoXj08YX?=
 =?us-ascii?Q?IJEucXG12iI3Hr+bNl9RX74OPBQZ6l4I6iJPzYYu5S+K5NcGH4cS58tAjJwr?=
 =?us-ascii?Q?Yw3c19PmFq2iGefhVL/Vn33eC6PbF6AY5yx+8yVeGaarf3jXedO2+8Vn2xGp?=
 =?us-ascii?Q?QC36EzhJFfjz9q8ZQ67/QIof851pdq4dPzJXcSaCa7O2C0ESw9CWYSHWCk5I?=
 =?us-ascii?Q?2wX/6EdkO40cIzxZYyXup2boDvpKzosKAF4mYARAw/WXV/wMXVgYQmNS0Ijh?=
 =?us-ascii?Q?+lyQd4sLcfUV+QrH8EPyVMOQAqhkwdJzu4bgNqRkZy8PaZnQLYsbrwaob86m?=
 =?us-ascii?Q?FYW3svdl8KHawmXUgUz6jxYhMM+kRVXFlCvS+vL7jOAexKAnyVJmKfJRRHhF?=
 =?us-ascii?Q?RsOUNaspGqH6tmyDVPH2eDpMbE3YsXQqgHcsYKkCRuGE+fZ32HB3s5EXvfva?=
 =?us-ascii?Q?fJqVbJ+EkhTVOwNu+4axaltXXzftjcVkxLOANazSYSNX0J7H/WrGDC3dVX1f?=
 =?us-ascii?Q?KQtYrzD6jA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d5a927-45f1-4c2e-cafe-08de51b2a7a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:14:49.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbZ0+x6zwlCtULoDaPWhG9X1TQeeHXvEj8R1lD3jyHZRLribaeAx5+11w5o80PnSQ6qyPuvV5V/DtwFwI2n+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-Proofpoint-ORIG-GUID: Mxw4BJpgfRyEUSwNUtSNQCr0I1ZtbDiu
X-Authority-Analysis: v=2.4 cv=fLo0HJae c=1 sm=1 tr=0 ts=6964ad7a cx=c_pps
 a=kwEYnkRUmkAH8qI+i8sEWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=97joFP1B6JbY72nZy3oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Mxw4BJpgfRyEUSwNUtSNQCr0I1ZtbDiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2MyBTYWx0ZWRfX6BBTxVthmSzz
 IfwELhlcOf7hSMyexiu3Hbw489+82Mt2TL5Jsbiv4ZGmsZc+a+XOuUUy7KW3iYnIijiMCRA8RTJ
 RXJuL3Nnbw0i/BJMmkF2BhJ+qIxLi89xUb/DJzAltAca/53YDETKhNykgxOEPKq5CLRTBK+Vklq
 /Q3cB+Zy+Ix30XREceHPkFTOcKdiPTdsJAb1T2JFoFA1pIQDZ9g5OVO5knrJ3MQeXgr/HGyhlpo
 E7MAk+tvlaJVzyUYm+9R3BMa2/VKvPHukgGJWx1XJFLqeP/2EwUwD1jP5HIKwbWCv6a7w/oFND2
 sBLIJHYWCd2URveESsUa35rNbGkDXcV4EJC/Uh9ice/n/fZLxWqGJxGazWPpPClRV22QsAyc5KZ
 xawd620mayQw3mA0Oa7B3piSrEJmh5KWJaIBBJdvVyPwSjDuH67q7tBgpogHHd8Y1GyNN03MwO4
 u9Se+284cmwPKJnc0wg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120063
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 08:15:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2945

Set PIP_NO_BUILD_ISOLATION to 0 to fix do_install error:
  File "/tmp/pip-build-env-ed1bjis8/overlay/lib/python3.13/site-packages/setuptools/_distutils/command/build.py", line 83, in finalize_options
    if sysconfig.get_config_var('Py_GIL_DISABLED'):
       ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "tmp/work/x86-64-v3-poky-linux/selinux-python/3.9/recipe-sysroot-native/usr/lib/python3.13/sysconfig/__init__.py", line 591, in get_config_var
    return get_config_vars().get(name)
           ~~~~~~~~~~~~~~~^^
  File "tmp/work/x86-64-v3-poky-linux/selinux-python/3.9/recipe-sysroot-native/usr/lib/python3.13/sysconfig/__init__.py", line 565, in get_config_vars
    _init_config_vars()
    ~~~~~~~~~~~~~~~~~^^
  File "tmp/work/x86-64-v3-poky-linux/selinux-python/3.9/recipe-sysroot-native/usr/lib/python3.13/sysconfig/__init__.py", line 503, in _init_config_vars
    _init_posix(_CONFIG_VARS)
    ~~~~~~~~~~~^^^^^^^^^^^^^^
  File "tmp/work/x86-64-v3-poky-linux/selinux-python/3.9/recipe-sysroot-native/usr/lib/python3.13/sysconfig/__init__.py", line 361, in _init_posix
    _temp = __import__(name, globals(), locals(), ['build_time_vars'], 0)
ModuleNotFoundError: No module named '_sysconfigdata'

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/selinux/selinux-python_3.9.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.9.bb
index 62226cf..7a4b781 100644
--- a/recipes-security/selinux/selinux-python_3.9.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -117,6 +117,7 @@ do_install() {
         PREFIX=${prefix} \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}' \
+        PIP_NO_BUILD_ISOLATION=0 \
         install
 
     # Remove .pyc files
-- 
2.34.1


