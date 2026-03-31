Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F7FF60DF
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 08:09:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15037.1774944561558011368
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 01:09:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qYdzQPNk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8550d9304b=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6E0o52187588;
	Tue, 31 Mar 2026 08:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=PeXvAgO1P
	sd3bP0R3HVqGPbdczHdKENtSodsAbFg24Q=; b=qYdzQPNk559BG7+W/3A+u5b50
	V5V3V0JRGcD5oFriPK3Zz8f3/Aw89qotScM1Sz641ftbm9jGeqnjSawyVgVhXHMk
	HH90E2OZB+5RguDEOSF95/1584e1pwf41AX7twuN/zD6XCtgS1E7HsUpgeXNnPqR
	JMG7Awd56cIq+/915Qt5ZS3pTh8X0SBms7DYrMw8WdSa8Aabxswq8S5J8GFZ15x5
	pK5MX1/NzqO3M06Sj4YONrFgtULIsZwI+kWfwp78by+M8XHE2HCQn5XhNnl4st92
	S0qYbVIbQTm8AU5SrnQUBemJlkj9zapdDbLgtWTeediedwlayJ8Qk4P6r+1DA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuc7h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:09:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqG2RiWxCUlFFiN3P03yuHrL0mh8eBInJlLUKll/zmxOlavr/SFk5pL99LUlEqF+nz4Gom416e0Qiz/dS6EJlLYRmEbYXdX5TubJCDDU/LhS59qjobc0/aNSlKVVLetD+v7pbS+7H+P4BGMAiglslqh4zcdLpkYGUNiBFEIHJzz5YGwOoz+ZX8xKW+2SlW3MFMhSUR0Qn8hObH6VWW5WAAyih/A3Ww/xnN74Y7Dif4S7h9OKpXbkw+30z1lidOeloyYo+OdVedwHUakfYDcAMw4nHoH5Xou2HeuXP7D6jAyXQ7fnMUWSLo/He1ohisM2JqIKTyB2j1++29C9mYB2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeXvAgO1Psd3bP0R3HVqGPbdczHdKENtSodsAbFg24Q=;
 b=WfrgMajTiSr/CKHPR9TITHxg8GjaQgZ3DQuopKOu4N8TLr9KG7YVdCyERcB6/zfJaIQOdKqEE2JLoCycNecIYZUP2F3Rvn7dIwQPgcjrMzmtXsAoi9EgER6PFR/hjlu1Jb3eAX6egLmip+qMUtFkamkZj6jqq7fOLuWhtmB75zB4IdTmKCfpPyyJP737Qu6LqECTiU4sTAwISsyYcMdzICRhtdNg+KHSIALQVgSDpiwvK8R6FKzGrJXz58lwZXrReo8qJBkmoXlzZlWDx0O/2PP0awQ3wzGFZDRJSyux0cpR/Q1NkpOs465x3dzkJIDoaoXFMfsbRoO9hcNA1Z+8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by CO1PR11MB4801.namprd11.prod.outlook.com (2603:10b6:303:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:09:17 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::531e:6ef5:812b:48f6%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:09:15 +0000
From: Changqing Li <changqing.li@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw][PATCH] mingw-libgnurx: fix do_configure failure
Date: Tue, 31 Mar 2026 16:08:58 +0800
Message-Id: <20260331080858.1069226-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:372::13) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|CO1PR11MB4801:EE_
X-MS-Office365-Filtering-Correlation-Id: fd78e8ec-f376-42fb-0fd7-08de8efcccd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Yy9riXKaqMiALbwQJjnt89JEzkj4bgI94J1yvzMTEXmuL+NpTgFz/Kcjhk/fmIZXulrcpkT454JY3Kblo4XeDYZYF8FCxIXcXNtkQu5LjLyNHssT7Tan7tkIDLkiyTvNxtMxabb/ChTjn4U3k8ZhjPkvqJJz0z5S0jignpw6mcBjzzX4CvMJUhCOYiehRE8IddJJuRdeQELC3l/XRsybWFAnma9+j8ybHiM5t8IW0CY7Y0l2yoX1ajF177uRda887NuKxuCLdjhMt+3k4aBH7HwcOxUFrFWP2Xd5VTTLkEsgLIXowei91Sgu8YTKg9JyXMdZieRpjRy1Lsa3URj0vMKtUikZy4PGAQqTnyI6DpIOroAQ2xaa+avV7ieA61kjr+waqDA4fz9/6SJB9qDkxjxcLThj2kKlrX7LpMyRbSA7Z0QfAqRwF7LIG3Ea5GSeL5pJFYGUO6EEWR7UtxpjS/YspCI56SgGanmLqjZvp/bwDKJO6Peg88jWfVgP1xuB1692eOKNpKBPfMwFPo+5d6jw5n9d90Svm5LzBwwyY8O3SjrK8Q7doybBADjDbnQAKB8AF6pyJDU0eqOj8rbx1VxeQKFHBzOtPKebawEXBgnuPncrMW449QvM7hHtRMn5M58e6fHZf1Lv6vxVUpI7N5TrU5NzdMjrY3iNIAb4vWsMgqJePYmB6YdpkyORyBf9pc41TjcZO0i3aQgm8dh+t258IWCgODbwzlWK8ZL835/P45SZ8QQPuDmyfP6FMJtht+YROd9/iGl1ocgkJtDSdmfMQfj1eNpq48TTmeDdC4M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W8HdrflpcSDMv/SmqR2XVtpWXfv/oge93rRzA9/cdpQKiHXTZINXUmx0xRsT?=
 =?us-ascii?Q?Xx54o1/aBi/IFLlA1r1JJf/bLs2n1AXB045jqHLJtYiWbQvItZk3vzrsgPe9?=
 =?us-ascii?Q?OmBdBkqq+9hAdXkoJ382ec3Ci3ZptAgumH5yNCkeaKteNA1NhHg81nwpKoHf?=
 =?us-ascii?Q?M6dSt+Ep6tRZPMH1KZ9FkgePkYlwXEDUuGClTUpVdhbWWgMqzrNHgDEDdpER?=
 =?us-ascii?Q?CYfxGkTTti/9JDEJZbv97VPyTZBD2dC22lPs4TSeWOIwGHJny/nzIi4/2wi2?=
 =?us-ascii?Q?ld8lQoLsKF1I3dR6FB9Ryflkvy4nVuASlwvaygsQjL+yXNENQZ6hnvR2pq0x?=
 =?us-ascii?Q?pXGMODQrmuoAN5/eWU3F4/1MYgOmSTtYX7pkC7820B3lJEeApM4tutzGTXjX?=
 =?us-ascii?Q?mEcAVbqWel6WzcPDm3zo+H/AU5Gz2aMNx13M8l/wJuGbDuE0HeFBTQYrdQGj?=
 =?us-ascii?Q?/1cGvpkyQ3v4V2QckMQJlmCl0Gq1/IOZ0dAwu2LuIe4rYUGuZGwMcuyocdlW?=
 =?us-ascii?Q?6Ofwi+CAJUdlY9WEqtibcDAAEOeZFZ2cmGaf7Vs8Ki7804WVuhlSpjqOSVtz?=
 =?us-ascii?Q?wsiyNJ2h8qAsfUgcGyWkt+7hcCe2ArpVvJYsBfLU+vn2I5MXLHmVtSfYhYr8?=
 =?us-ascii?Q?nhs3Zt9BHfNLSHOkttWcLrxCoa0m3zAunOHR79d9FqnbeQ184i5o/X1wxIwg?=
 =?us-ascii?Q?MdqEeNx4QJlXlZ9QfuXrd2ncTLJeUVxLrEzkGx4BssLUdMUl04k1IXRIhhlZ?=
 =?us-ascii?Q?XxtSx6y5rpcV/Hup3LZbRhT3j3FvoyRh/VDBoqturyxpLC7p7tEef+ITBOiE?=
 =?us-ascii?Q?eL2b+vtznUwY0Sa0Tto8Qy+IUEo8EyytaQ1XyjlnYVA7VW4sMPtVJqdq1A7x?=
 =?us-ascii?Q?VAic9fcgjgWrC3+JVo1xn88Ka7bu+o6Le09KwGHR+kwUBtlxhjnCQKTO1VPH?=
 =?us-ascii?Q?sJdSOntJEQtId6hdXiJlsUYFTKFgUSUajrm/FKASwsbyBIwTK0M6It8J0TUa?=
 =?us-ascii?Q?8gDACE7GngF2snFt/XDW6X0Z6NiIgd3HY0Mn4a4DXbpgceEsEhUWDOpx0nCD?=
 =?us-ascii?Q?dOOMks3afgAPfvXu08RtxUtUCSjRxVxzLGSUY+TiwTv2LA0VgJ6dQsjKUMjT?=
 =?us-ascii?Q?WGe3Qdl6B3SYO1ZM8/0IjI/22mhdHWSC1hqBYzD64r0TN2CBy+ABkzM84mGu?=
 =?us-ascii?Q?jZHPkmUbKukGe8VSZLltARff2xhc6PqRcBhHhYSk4oARXc9/rGwQ1OCJrNay?=
 =?us-ascii?Q?Dni1jGLeVq/aI11qSSwt36i6K/d7H1DjBdpKRbi/ZoVtf3CRbvlidXDFBBXi?=
 =?us-ascii?Q?jsJULnrUrPLr/23P2hUwE9XGdHn4EpqQpyonm2tAbeRdXUuAVkPyrkC8XnJn?=
 =?us-ascii?Q?tJlUqAdjdgUSvYsIfpE5hRasL8pMU06CC1UxpdjSVLFxjuXTjHlpBu1n/BLY?=
 =?us-ascii?Q?fEUHYiiTEg0cNN/mXFvcEdFYBZR60nSu3mx1r9FXwpYunZwMsJelcZu8pFhh?=
 =?us-ascii?Q?KfRZK07S82y4TufTtjxbTfGlxe4AsE1VUfziu7fkeqI7Xtg5kkIV/7cPcVQg?=
 =?us-ascii?Q?+xdmeyTyNUGkpVdQAFllADQyGOrqHGJmHYLKiCt5wKJp3+VCW4Tc8ULf1iHJ?=
 =?us-ascii?Q?yX39/lOHxr5UZtDa1Fc2mxI1owTtlvz3lyQzgyG63jSU28kXo1BzMNy3bSw9?=
 =?us-ascii?Q?1ULjdxsq/zPhwGV+eJfcQxSBtRgh3LnJ22MBKHACjySKlplZx+f3k6RdQFGb?=
 =?us-ascii?Q?GH70rvE//ZtIklF3546PQ4zfzPOwyhg=3D?=
X-Exchange-RoutingPolicyChecked: 
	qxZ36Nh4x53gIUjRs9e0r/7dARGmGV1J+xPmY3Sj0jKUbhK9nxv0jQfZftDl285O2i+5W1bEArAxWIAeH46OtyYsyVJeDFOxUvOcHWqz3sTc4q25HqgSLx21K6YcIarKGJDy9fQp5X2xdRA3LOgBPEqlZzjm5j5URV+Q0ciEOdf1XxgiceFMRqsJjDY2MWJizsoNDD5+I9vdM7Y1jPurtJiYCDyY9rnXJK/evFbhPZ7oGQyd9MWuYUEUnleFK+j/PXyGZagiiCqXCqZHnpUGuRMiswfKM1xpruQvTnOGR6C87FvoEOVS9x+eeK1DP1mzQJS/PLBdEQmsr3MLXzoQ/g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd78e8ec-f376-42fb-0fd7-08de8efcccd5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:09:15.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4W7qk3GVXoyLE0w1FgmXFe7jlR41FC0HufAVuH4oHf388xz381ypdXqSfcwpHqJBwNkGuTUzKsU+AynYhFeWGyArYjz4YAgLs7/CpF+Sri4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4801
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cb812f cx=c_pps
 a=imb72M7KABO0D7Cp285+Zw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=T24DDs6eBq6Sz3G6-0gA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: MbuyMxG-veziJ-dEfQNvJIdqLjYasvhx
X-Proofpoint-GUID: MbuyMxG-veziJ-dEfQNvJIdqLjYasvhx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3NiBTYWx0ZWRfX78UCLEwS69he
 hkBJLDuCaGr0fAJBPi1cmhehz8n1EvVsHrlXerKVDVaiauvv/QKOKQ1ieqz76UMwM1edsvHm+FM
 mTa3QHmtESSMjyczQS9y0fmELEGyJCVstrRdCgCqaNienkebh/2p/P7Xo6cY52p5mMsA+bplKEB
 aA0oeOTvqjCtPnDYO6tIdmd3YyNAaIwGZQh5HKuxBHxKKfANwBMJsHTmcmoYF6A49YucOYOB4Q7
 /lETx3FStqcbLfmQ4//ULvY1OxW9nqap8Rqe2OAomjLfoPmO4NVrLi+hxslM0G9H1jtQ0aco5mZ
 rGZhxxnS6ygpVHfUEaUwcV9RgzCvmgE93qf6+W1V+ZNUpwIeiKH8DsYSCAY8ymXkOqwbEDXgxYO
 NtFC61oJiigKOq8zsuoAz3MrNgfvmYZ51OrzG5O2ygeeC/ZVmRRrnJcPK2bwrrVUsVINZIYwX9+
 jfUAin2t3FQakGKjp8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310076
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 08:09:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3589

Fix do_configure failure:
| NOTE: Executing ACLOCAL="aclocal --aclocal-path=/tmp/work/x86-64-v3-wrs-linux/mingw-libgnurx/2.5.1/recipe-sysroot/usr/share/aclocal/" autoreconf -Wcross --verbose --install --force --exclude=autopoint
| autoreconf: export WARNINGS=cross,no-obsolete
| autoreconf: Entering directory '.'
| autoreconf: configure.ac: not using Gettext
| autoreconf: configure.ac: not using aclocal
| autoreconf: configure.ac: tracing
| autoreconf: configure.ac: not using Libtool
| autoreconf: configure.ac: not using Intltool
| autoreconf: configure.ac: not using Gtkdoc
| autoreconf: running: /tmp/work/x86-64-v3-wrs-linux/mingw-libgnurx/2.5.1/recipe-sysroot-native/usr/bin/autoconf --force
| configure.ac:5: error: possibly undefined macro: AM_INIT_AUTOMAKE
|       If this token and others are legitimate, please use m4_pattern_allow.
|       See the Autoconf documentation.
| configure.ac:7: error: possibly undefined macro: AC_LIBTOOL_DLOPEN
| configure.ac:8: error: possibly undefined macro: AC_LIBTOOL_WIN32_DLL
| configure.ac:9: error: possibly undefined macro: AC_PROG_LIBTOOL

Autotools.bbclass don't remove aclocal.m4 after commit:
oe-core: [7da2290a46 autotools: remove deletion of aclocal.m4]

Usually, autoreconf will always run aclocal, except when the current
aclocal.m4 is not generated by aclocal, see snip of autoreconf
[snip of autoreconf]
  if (-f 'aclocal.m4')
    {
      my $aclocal_m4 = new Autom4te::XFile 'aclocal.m4';
      $_ = $aclocal_m4->getline;
      $uses_aclocal = 0
    unless defined ($_) && /generated.*by aclocal/;
    }
[snip of autoreconf]

For mingw-libgnurx, the exist aclocal.m4 is not generated by aclocal,
so aclocal is not rerun, and configure.ac is updated by patch
0002-Add-autotool-files.patch, so configure failed, fixed by remove it
before do_configure

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
index 5318ca4..3c46810 100644
--- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
+++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
@@ -17,4 +17,10 @@ inherit autotools
 # Specify any options you want to pass to the configure script using EXTRA_OECONF:
 EXTRA_OECONF = ""
 
+do_configure:prepend() {
+    if ! echo ${EXTRA_AUTORECONF} | grep -q "aclocal"; then
+        rm -f aclocal.m4
+    fi
+}
+
 BBCLASSEXTEND = "nativesdk"
-- 
2.34.1


