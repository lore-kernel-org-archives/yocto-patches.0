Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4DCAC5BD
	for <webhook@archiver.kernel.org>; Sun, 28 Sep 2025 02:26:53 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.25298.1759026408775916010
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 27 Sep 2025 19:26:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ZS82c9cj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=13661b3d59=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58S2011d1308993
	for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 02:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=1mf20J+o8MIXAq5WLsE/
	wk4Iub6MwrdrNy0aaav2F8w=; b=ZS82c9cjvNZlaqrXvL+TBYDaUVlVVLW+xYk5
	cXK6axgemDwJHyTIrYOQWiGfSeLWzvYpq8Dl8JbFFX5MKbVUvTWWLVG2XC5GZOWi
	Mzqeo4MI969bObdYjOMVSdapFDELgwM+Zqi3f56oJcymeSOFmAXALDsmvlELVDbY
	IboRlpolDWCnAHtd5RrMLp3ffvAoVab/KZfmzru9d2QlMYWp6vSlwXbNSZPzCsbl
	gneWDl20xHOMzy7yhK5AdhNMmUXmFNevSc+dDdeUGGOut+GuyWxEFyFe26mBnV3T
	Y/fMWX762eatzHbHaS9Q+jawR+VU7bpSFNhieArra5pMdrsC3w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49e6w7gqg0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 02:26:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UubeqDk0CykDjd30YfLHDNB7HdS+6hOy2wcHNvhW8X77Am424/7cdeIa3PIEgYcVr2k0dIVDpQN0C7hGHNet5pbrN7UFxbBsr/iJqVWUYUClVQAnWE//16WbSZHbuX77cOW9OY/Bbe6ThKtbknrFV45ZVASOL80Mqi/keVefUNbo+izVUzo3Ml/Q7cSI1WoH7qJSvXnADxlmyyvL5OlUN/y++PLCSlkOM+N6YR0GI98YvtsSzC+msGMp+Ial+yXBSn89nT501ruafwcp20y7C+UR/ilk4xnZ4DIZJzNQ4dz3yPBx0j2zb+uZ1MpQUwQY+yjdmXVrqLMBIxMmIa1LRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mf20J+o8MIXAq5WLsE/wk4Iub6MwrdrNy0aaav2F8w=;
 b=c+XBkLDor3xum2i5CBOrlDYyFjD78ap07Ij96sttSNKZTPu1F7vVT9zwAqr2xIQbrS3UWzN98D4uN6Cdx1sImvbhzNJ2T6wzUmpHcZ/bi3evgnMu9cPdk0n+DcThs62VvRNJMGK2/6BsusWkVhsn0QuAs/RwFHEjh7YIEBaWqTxdPktjWn4RLmQzufyFprbQ26z33FoXNuP7sSRLsjZ8wwPxSoYUQFScmcdkNkCLE0b65LZj4OcADGrBYDrr8anZJ6A9QmbIOCUboEq8vnYtM3c0BdvmXQdOM3EGk+g7+0UfukVCp92PXrfc/tsc/cTE1TaYr7fhi9Xw5PgZG9pzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 LV8PR11MB8488.namprd11.prod.outlook.com (2603:10b6:408:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 02:26:44 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 02:26:43 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: upgrade 20250213+git -> 20250923+git
Date: Sun, 28 Sep 2025 10:26:28 +0800
Message-Id: <20250928022628.891594-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|LV8PR11MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ea8b71-cce1-4daa-69c4-08ddfe3676bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ztsSgGSV9Lfz72zb1TeJx2Wm/conJ9wa8Tio+4ZPy9wIiepn0uqbhvNjRk8B?=
 =?us-ascii?Q?2f1xQ1Y8G7bZaDpGLnamL7ORcWtAJQrr9Nd9lRYTOKzRY2kzv73uMJtlC0+z?=
 =?us-ascii?Q?iN+WqJAq5CmZbCkWQnXSbjtkxDQLLZrtaQ9snQdVKI2dZDVMoNPPzRl+aX5p?=
 =?us-ascii?Q?ieIF09KNZTHo3xnTO24cxB8qdoEVElQi9dU01BHeuLL1z0S08C0cnNdLf3dx?=
 =?us-ascii?Q?8+I5E0ZquPF2nE6uv/oYidZFqS0eoJ5gWQBoalEUtyAiFe/Uog8Hymx/tjEp?=
 =?us-ascii?Q?+qefzJE/YAolY9KMQgGdnXMwGDY0E+T+MxukjKEuiNcM9IXx58fBo6uwYjuN?=
 =?us-ascii?Q?Ycu0WKmNu8BYu4o3/NAqOcDnyZt8rfj9Ft6pf1NcggzyaG4aBa6h04xDVyY6?=
 =?us-ascii?Q?VD/hAZCvhmghPk5VhPFpOdS/O16/3YdTG++NqoAhMWOWVzLlZHhZC89bVa8h?=
 =?us-ascii?Q?eA624YkF1epeHl2Uh/3hZ52GsTcc5UCrBw7J5KUojMIWD+DWWn0U3VQQEfZU?=
 =?us-ascii?Q?rMT/CHU2bqrgZNhgXYEymGO28AmayJON7foZeIb2v19W/FITzji61jjuujG9?=
 =?us-ascii?Q?0a/5uX1q2Mz+m6LqUxuJCK/Q6AKe7HzU5MVqsZO19bg0/ezRhzRzLf34hW9b?=
 =?us-ascii?Q?QAJ6XyeiyBq4NWgwm8r9tI6+DSQnIbIwvJytlEWs8IQMXjic3scYh2YRXE+N?=
 =?us-ascii?Q?KrhbCbnnCk+VCCoyMv2Ljacjtgb10RpeejNHAK8b9F2toJzp2g31K+bhrVuW?=
 =?us-ascii?Q?qWyoil2F5dK1kfr4LLMkWovRNk8MWzk5yde/UPWs8P598Oq6NUdNFtlFjJHg?=
 =?us-ascii?Q?FEWWo+AQPWW+MbutXNQ5qRfNSiRVIo/PJmY+MJk2blvc0tLCIqXD+sZMrTb/?=
 =?us-ascii?Q?obxZRIu9+Nd5011XCwPtk7e4gbxE4/XwA7PVt/Y1wOXSoQXmDCTCREBCCu0h?=
 =?us-ascii?Q?8VsDnXzhiIPQ9Xtl07q6jquLJQ519gfQiMq53EsE41E11tGkVslhHTpe1x50?=
 =?us-ascii?Q?7qB8H6cdXoR4mjSHbTHc9MoLYA4JiQuu0Xg7WIOlnaAuQ3j55QY6vzsQL+Dp?=
 =?us-ascii?Q?4u+o8+eOYpvogk8uJ5Y6rhUW5maWyzOUGWJVaOiqFHpfJBgG/P5OUbsU41un?=
 =?us-ascii?Q?kFt/VWwJJ/f589AjZqXwdXvKjgFkWHjF13KFvrPyU5C+NrirOsM1TpCg2pk/?=
 =?us-ascii?Q?s2tgnLNY2u5cLcCr/TPcqHU3T5U19EmmEQMvqziKRriH3yI7W2TCY3T8fito?=
 =?us-ascii?Q?PUbYlQ2K/QnK7P4f4eN9Dp4A7WQHpSM5V1V+nB1ESmB+yPhZQlGUQ7ScREkw?=
 =?us-ascii?Q?HJJK8bcgex4rcnOk9s13FZ+P9AXs7bf3fEqYxxcaLbKP/3cdAyjZi2VmrSzK?=
 =?us-ascii?Q?A0LqwMV9CURuqcdzY6WvyHF51Nl+2rfrYtndUbHWsW7iSGe7k+lygzRv0s55?=
 =?us-ascii?Q?e9B5J14iBd6OjXzqTL6km8PVAfGuCQsv2o517B50GYryn+QYcXqXNjpkF/3Q?=
 =?us-ascii?Q?450hJ0vKKng/Tqlo/VGXnrzxFDiotttffZzIFBR3TQLNPjaEpPwr39xslg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xFRKRVBaYwou+pMiSlTysQTAqTjByGXXywBgCyrYoCOdv5knnEKsHqncIKYE?=
 =?us-ascii?Q?zKaG1s9KRMRKt/FwNv+d1YlBUGRmJAnIqME4kuxSBvpCPO42O43pfgHnLtc4?=
 =?us-ascii?Q?LNYQ+dzoSbuAKQLs7yooeccm2J2k+JtQ084w8dXVgU46Rzb4Ipogh89SWOJM?=
 =?us-ascii?Q?KJ7Lo1fVF63mUpGqLuBkY1lD1xBlJv+CG/M5f/RlI6ZIOn3lXduLmw3aaO/z?=
 =?us-ascii?Q?cFvz9/Jj6ktgMKHmT2NcKXVeVh17kcRpnQLLbGPYEsB27BmtaaifNkLD9Glc?=
 =?us-ascii?Q?smmCFp4xvli1oWHFfmU6murHgHbAMCJuGhh36BQ4iTjL1ARMYtwkjIoLO4Jt?=
 =?us-ascii?Q?hUmaxw3gvR7rT/nlBMqheoigAK2y3wZ2P9RpKiQ6VIPKETBBwDSvNQIXVdwA?=
 =?us-ascii?Q?xUNd7eKJHu6tYqwWF6frVSZgO0N3SI8kHpGmgVyOIQmHmRAoy5WuSu7tKinO?=
 =?us-ascii?Q?ZItL8H/PE4D/S1j+A2zoZvWDOBm12t2TC1eWl60u7OdqXnkSf52uUBqcdew3?=
 =?us-ascii?Q?mHWMlqO1/F+5kNvQmIAw/zn5N3ar2HtFxf3s6LorIy0KZhdtqZTSBUIroZcL?=
 =?us-ascii?Q?WrFBmnguQN2l1dOHW2fVvkvmqL1XpguiTVI/uql8Hsx9QGFNBvfw/EFTL3jW?=
 =?us-ascii?Q?PepK+7m0SlokmE+2tdtfAHPZCttWQaGX7Mwy2pPasOgPLdDIXM1R7E1E/kkC?=
 =?us-ascii?Q?nsqXamXoECUGd/68x+hvw9hBfeRFfVtP6xalSVif5ECRQ6agpIJWOgLYPRnc?=
 =?us-ascii?Q?1EAtsEbq7SOWOT+JtNaX/leTJ9gF2zhUXZiTN9l3I71sVrv2dFwJW/o8jR/w?=
 =?us-ascii?Q?uMWT1099wZuZxhV2nrtE0T313+QBZL/UIahMKNdDCkDxH3qfI2uEqYaNpvsN?=
 =?us-ascii?Q?/QLu9JUMyCj4Awq591uBKEmWDTEmmO7wvqJ3jW2mFGlohXDfGVPQJRciTaC/?=
 =?us-ascii?Q?wlqtjlQZJbcsldHEtQBMUYcvVNCDxegPTqRMvCYlLNOBBN11aUeOV28Fk/N5?=
 =?us-ascii?Q?tNoS52RGH16xpprGqBsoRMgSoLzIgOIsjJ2Tk5AaVKV0ClrXA4sBV41FV/VX?=
 =?us-ascii?Q?umJY7JKhBr3+Z45EAS0f+IomYHOOlAuTuqqyjNI5enpzIVigJ3M5RVE6rGjv?=
 =?us-ascii?Q?xswnXEVzlndr/MwGYyIhxV6rO6OHaHj9xOXTbt0GRpzXUSs9z4BNdU4UJZv2?=
 =?us-ascii?Q?aL1AUXgpECAnIAbkx6X5Dhhg+iRnP4440DEuWVaQK9LiLbgFTDcGH6hXbIy6?=
 =?us-ascii?Q?X94GW7I+UtwZkQ8WwlinN7rPQjmMvW6wFf8dKuubiDWrRNKV02/JEUivG6ig?=
 =?us-ascii?Q?+mD64bMgNl8j0vdOcm+yzXZg1Wt+THvAzTUNPA54VhQ33Itg9EbnkKfIGT1O?=
 =?us-ascii?Q?/jpDwIWGC29qBBv1Vcd9zuAMlC3AK8fod4f46ixdLBb6P2fRr45dHZwnZ4M+?=
 =?us-ascii?Q?+Ro5pDciz0stRh8Dpl91NHeN29FuxCxgxzIzxxkT0AQ3fbxDwv6VRYQncuSn?=
 =?us-ascii?Q?b2ZzGSPkbAzUUGV+laIvPUflsCevZSCa5bBBKlI3T+b0qmbY40MYAFmOXkmV?=
 =?us-ascii?Q?wrs02dVA+E8D3PuMklVo5XOg4bjv6mr/V4NZnQlp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ea8b71-cce1-4daa-69c4-08ddfe3676bc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 02:26:43.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWv9nIVsMLumEcfjHCYralfn1OvdWQab7WL+uj8IBGDsIpSgsliieHGNtZPgBB6bHa/3xoixkc4stBJJTa384Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8488
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDAyMSBTYWx0ZWRfX/+LD82RAbV3K
 2laq0n9gu/xpaKVb29dAhyVDnbesU2ZjrCY3ajwgEOQ5T4TK6pCN0Zami62Umw8te+fG6JYrYfp
 tuP11nvtNvAnU0ihDV7+vlMSuVdIIr2mqdGgLq5lxRIi6fUOdp5yKSPzBgN0b9GwL6Vq7PZVt3x
 9/EhsgThvq6d6fNe0yx+VGBa3PXpfYNZo41FULU05c8YpU9OHY6L1QsZ4eFLFo14eLpuo/gm/MT
 fjTl1v376Pcd6W4/3YNMNyh/FdY9GxLiKYZ0UNtQ9RJw5CIX0lZ4jXfLIozmsvQohex+ZJslSL3
 4LyoQma6RHTPcYgQ6uSh2vjcLGciYrOQML8qyqsDSlHuWt3kYdtR8BWJsNocw7U+w9mCWiVI14k
 YdwF75COuMBegvy2jY26dZgF66S+BQ==
X-Authority-Analysis: v=2.4 cv=Lc0xKzfi c=1 sm=1 tr=0 ts=68d89ce7 cx=c_pps
 a=z/rjtr9/JqYX5j7IdmSYkQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8 a=N2BjXkL6dBhrVzh6G3wA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-ORIG-GUID: N23BDUXcjdKwz3-7mGma-1R4etPaDgUX
X-Proofpoint-GUID: N23BDUXcjdKwz3-7mGma-1R4etPaDgUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509150000 definitions=main-2509280021
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 02:26:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2245

ChangeLog:
https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250618
https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250923

Notable Changes

20250618:
* Updates to support screen 5.0.
* Add labeling for bcachefs.
* Various systemd updates and fixes.

20250923:
* Several updates and fixes for systemd
* Add new permissions and policy capabilities
* Drop reiserfs support (it was removed in kernel 6.13)

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...tile-alias-common-var-volatile-paths.patch |  4 +-
 ...inimum-make-sysadmin-module-optional.patch | 12 +--
 ...e-unconfined_u-definition-to-unconfi.patch | 12 +--
 ...box-set-aliases-for-bin-sbin-and-usr.patch |  4 +-
 ...m-allow-systemd-networkd-to-accept-a.patch |  8 +-
 ...ed-make-unconfined_u-the-default-sel.patch |  6 +-
 ...y-policy-to-common-yocto-hostname-al.patch |  4 +-
 ...sr-bin-bash-context-to-bin-bash.bash.patch |  8 +-
 ...abel-resolv.conf-in-var-run-properly.patch |  8 +-
 ...-apply-login-context-to-login.shadow.patch |  6 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |  4 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |  4 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |  6 +-
 ...ply-policy-to-network-commands-alter.patch | 10 +--
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |  4 +-
 ...c-su-apply-policy-to-su-alternatives.patch |  4 +-
 ...fc-fstools-fix-real-path-for-fstools.patch | 17 ++---
 ...fix-update-alternatives-for-sysvinit.patch |  8 +-
 ...l-apply-policy-to-brctl-alternatives.patch |  4 +-
 ...apply-policy-to-nologin-alternatives.patch |  8 +-
 ...apply-policy-to-sulogin-alternatives.patch |  4 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |  8 +-
 ...pply-policy-to-kerberos-alternatives.patch |  4 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |  4 +-
 ...ply-policy-to-postgresql-alternative.patch |  4 +-
 ...-apply-policy-to-screen-alternatives.patch | 25 ------
 ...ly-policy-to-usermanage-alternative.patch} |  4 +-
 ...tty-add-file-context-to-start_getty.patch} |  4 +-
 ...-apply-policy-to-vlock-alternatives.patch} |  4 +-
 ...or-init-scripts-and-systemd-service.patch} |  8 +-
 ...s_dist-set-aliase-for-root-director.patch} |  4 +-
 ...stem-logging-add-rules-for-the-syml.patch} |  8 +-
 ...stem-logging-add-rules-for-syslogd-.patch} |  8 +-
 ...rnel-files-add-rules-for-the-symlin.patch} | 26 +++----
 ...stem-logging-fix-auditd-startup-fai.patch} | 16 ++--
 ...rnel-terminal-don-t-audit-tty_devic.patch} |  8 +-
 ...stem-systemd-enable-support-for-sys.patch} |  6 +-
 ...stem-logging-allow-systemd-tmpfiles.patch} |  6 +-
 ...s-system-systemd-systemd-user-fixes.patch} | 17 +++--
 ...oles-sysadm-allow-sysadm-to-use-init.patch | 36 ---------
 ...stem-logging-grant-getpcap-capabili.patch} |  8 +-
 ...stem-allow-services-to-read-tmpfs-u.patch} | 18 ++---
 ...rnel-domain-allow-all-domains-to-co.patch} |  4 +-
 ...allow-systemd-logind-to-inherit-fds.patch} |  8 +-
 ...temd-tmpfiles-to-read-bin_t-symlink.patch} | 16 ++--
 ...-systemd-networkd-and-systemd-rfkill.patch | 76 +++++++++++++++++++
 ...stem-mount-make-mount_t-domain-MLS-.patch} |  8 +-
 ...les-sysadm-MLS-sysadm-rw-to-clearan.patch} |  8 +-
 ...rvices-rpc-make-nfsd_t-domain-MLS-t.patch} |  8 +-
 ...min-dmesg-make-dmesg_t-MLS-trusted-.patch} |  4 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |  8 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |  8 +-
 ...stem-systemd-make-systemd-tmpfiles_.patch} |  8 +-
 ...stem-systemd-systemd-make-systemd_-.patch} | 24 +++---
 ...stem-logging-add-the-syslogd_t-to-t.patch} |  8 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |  8 +-
 ...stem-init-all-init_t-to-read-any-le.patch} |  8 +-
 ...stem-logging-allow-auditd_t-to-writ.patch} |  8 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |  8 +-
 ...stem-setrans-allow-setrans_t-use-fd.patch} |  4 +-
 ...stem-systemd-make-_systemd_t-MLS-tr.patch} | 12 +--
 ...stem-logging-make-syslogd_runtime_t.patch} |  8 +-
 .../refpolicy/refpolicy_common.inc            | 71 +++++++++--------
 recipes-security/refpolicy/refpolicy_git.inc  |  4 +-
 64 files changed, 352 insertions(+), 338 deletions(-)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
 rename recipes-security/refpolicy/refpolicy/{0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch => 0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch} (97%)
 rename recipes-security/refpolicy/refpolicy/{0024-fc-getty-add-file-context-to-start_getty.patch => 0023-fc-getty-add-file-context-to-start_getty.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0025-fc-vlock-apply-policy-to-vlock-alternatives.patch => 0024-fc-vlock-apply-policy-to-vlock-alternatives.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch => 0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0027-file_contexts.subs_dist-set-aliase-for-root-director.patch => 0026-file_contexts.subs_dist-set-aliase-for-root-director.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0028-policy-modules-system-logging-add-rules-for-the-syml.patch => 0027-policy-modules-system-logging-add-rules-for-the-syml.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0029-policy-modules-system-logging-add-rules-for-syslogd-.patch => 0028-policy-modules-system-logging-add-rules-for-syslogd-.patch} (87%)
 rename recipes-security/refpolicy/refpolicy/{0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch => 0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch} (77%)
 rename recipes-security/refpolicy/refpolicy/{0031-policy-modules-system-logging-fix-auditd-startup-fai.patch => 0030-policy-modules-system-logging-fix-auditd-startup-fai.patch} (76%)
 rename recipes-security/refpolicy/refpolicy/{0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch => 0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch} (87%)
 rename recipes-security/refpolicy/refpolicy/{0033-policy-modules-system-systemd-enable-support-for-sys.patch => 0032-policy-modules-system-systemd-enable-support-for-sys.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch => 0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0036-policy-modules-system-systemd-systemd-user-fixes.patch => 0034-policy-modules-system-systemd-systemd-user-fixes.patch} (85%)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
 rename recipes-security/refpolicy/refpolicy/{0037-policy-modules-system-logging-grant-getpcap-capabili.patch => 0035-policy-modules-system-logging-grant-getpcap-capabili.patch} (89%)
 rename recipes-security/refpolicy/refpolicy/{0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch => 0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch => 0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0040-systemd-allow-systemd-logind-to-inherit-fds.patch => 0038-systemd-allow-systemd-logind-to-inherit-fds.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch => 0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch} (90%)
 create mode 100644 recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
 rename recipes-security/refpolicy/refpolicy/{0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch => 0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch} (84%)
 rename recipes-security/refpolicy/refpolicy/{0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch => 0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch => 0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch => 0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (89%)
 rename recipes-security/refpolicy/refpolicy/{0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch => 0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0049-policy-modules-system-systemd-systemd-make-systemd_-.patch => 0048-policy-modules-system-systemd-systemd-make-systemd_-.patch} (84%)
 rename recipes-security/refpolicy/refpolicy/{0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch => 0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0052-policy-modules-system-init-all-init_t-to-read-any-le.patch => 0051-policy-modules-system-init-all-init_t-to-read-any-le.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch => 0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch} (87%)
 rename recipes-security/refpolicy/refpolicy/{0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (83%)
 rename recipes-security/refpolicy/refpolicy/{0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch => 0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch => 0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch} (82%)
 rename recipes-security/refpolicy/refpolicy/{0057-policy-modules-system-logging-make-syslogd_runtime_t.patch => 0056-policy-modules-system-logging-make-syslogd_runtime_t.patch} (90%)

diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 87febdc..3d84620 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From c36ccb73201949df2e4e01dc12e36c77bc42e099 Mon Sep 17 00:00:00 2001
+From e27062c7d2845b421374b390bb300f60793316b5 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -29,5 +29,5 @@ index ba22ce7e7..23d4328f7 100644
 +/var/volatile/log /var/log
 +/var/volatile/tmp /var/tmp
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index f963901..4a9e963 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From abcc9a219a57c4cdc60f72cd91372204f3fcfa38 Mon Sep 17 00:00:00 2001
+From c2203debb7315bdbb0262a29e00477f8acc4e0d1 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index bde3d5944..cff62daa0 100644
+index c4c1a5323..956c5679d 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -653,13 +653,15 @@ ifdef(`init_systemd',`
+@@ -677,13 +677,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,10 +48,10 @@ index bde3d5944..cff62daa0 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index 59bcc78c8..f25168e3b 100644
+index 75ee52efd..74593c55b 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
-@@ -280,7 +280,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
+@@ -285,7 +285,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
  userdom_search_user_home_dirs(sulogin_t)
  userdom_use_user_terminals(sulogin_t)
  
@@ -63,5 +63,5 @@ index 59bcc78c8..f25168e3b 100644
  # by default, sulogin does not use pam...
  # sulogin_pam might need to be defined otherwise
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
index 6907b19..6bcf6e0 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -1,4 +1,4 @@
-From b14a64cd3a83e0c3741446cb5bca4773f7db5e6d Mon Sep 17 00:00:00 2001
+From cc5872b91123b4bd66a906bb9f46be5410669634 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 19 Feb 2025 21:35:02 +0800
 Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 10 insertions(+), 14 deletions(-)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 987709345..2dc5c3895 100644
+index 7ec2aa471..8f0f6ac2e 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -33,6 +33,9 @@ role sysadm_r;
+@@ -37,6 +37,9 @@ role sysadm_r;
  role staff_r;
  role user_r;
  
@@ -32,7 +32,7 @@ index 987709345..2dc5c3895 100644
  	role secadm_r;
  	role auditadm_r;
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 6dc1d9484..68b78ff24 100644
+index 71e1b15ae..940c98ce6 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -8,9 +8,6 @@ policy_module(unconfined)
@@ -45,7 +45,7 @@ index 6dc1d9484..68b78ff24 100644
  userdom_base_user_template(unconfined)
  userdom_manage_home_role(unconfined_r, unconfined_t)
  userdom_manage_tmp_role(unconfined_r, unconfined_t)
-@@ -253,14 +250,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
+@@ -273,14 +270,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
  optional_policy(`
  	unconfined_dbus_chat(unconfined_execmem_t)
  ')
@@ -79,5 +79,5 @@ index 25402afd8..ca203758c 100644
  # The following users correspond to Unix identities.
  # These identities are typically assigned as the user attribute
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 26b1d9c..674f394 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From 1fd50ccbfb7943a4e479af91d308f433f1f0ec8a Mon Sep 17 00:00:00 2001
+From b99da006e440106534655b2fabfa414dc4fbc899 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -29,5 +29,5 @@ index 23d4328f7..690007f22 100644
 +/usr/lib/busybox/sbin /usr/sbin
 +/usr/lib/busybox/usr /usr
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
index e4d697c..1dade31 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
@@ -1,4 +1,4 @@
-From 805d55ae146a21575b013e041cec7f97899d39ae Mon Sep 17 00:00:00 2001
+From 0a0de54c7a95e959bcf9c34dffc1fc21291d994b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
 Subject: [PATCH] refpolicy-minimum: allow systemd-networkd to accept and
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 45d4db784..af0e05e9d 100644
+index e4f53fe66..19f8368a8 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1305,6 +1305,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
+@@ -1439,6 +1439,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
  allow systemd_networkd_t self:tun_socket { create_socket_perms relabelfrom relabelto };
  allow systemd_networkd_t self:udp_socket create_socket_perms;
  allow systemd_networkd_t self:unix_dgram_socket create_socket_perms;
@@ -43,5 +43,5 @@ index 45d4db784..af0e05e9d 100644
  manage_dirs_pattern(systemd_networkd_t, systemd_networkd_runtime_t, systemd_networkd_runtime_t)
  manage_files_pattern(systemd_networkd_t, systemd_networkd_runtime_t, systemd_networkd_runtime_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index 57eb976..fc8e0e3 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 0b299c6f8950cbba592a366e93f9ecb0605ffe9a Mon Sep 17 00:00:00 2001
+From 275d9a2e0d59f27797d74e4a9b39ad8e1041b7d0 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
@@ -38,7 +38,7 @@ index ce614b41b..c0903d98b 100644
 +root:unconfined_u:s0-mcs_systemhigh
 +__default__:unconfined_u:s0
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 68b78ff24..d54fe2fd4 100644
+index 940c98ce6..c8f3f9c3b 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -20,6 +20,11 @@ type unconfined_execmem_t alias ada_t;
@@ -77,5 +77,5 @@ index ca203758c..e737cd9cc 100644
 +	gen_user(root, sysadm, unconfined_r sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - mls_systemhigh, mcs_allcats)
  ')
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index e2dd9e0..65c7b2a 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From db25a33d356c7c273c1bcee33bd1f5df80bf29b0 Mon Sep 17 00:00:00 2001
+From 2febe93c54945827d753bb2df9e85341d2086a36 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
@@ -22,5 +22,5 @@ index 83ddeb573..cf523bc4c 100644
 +/usr/bin/hostname\.net-tools	--	gen_context(system_u:object_r:hostname_exec_t,s0)
 +/usr/bin/hostname\.coreutils	--	gen_context(system_u:object_r:hostname_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index f5a012f..2763cb0 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From 2016c05b60f0d81294ccccc4242e03d4143b843e Mon Sep 17 00:00:00 2001
+From c66bca3019b40cd6d626ec62331cc85fa459f253 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 9ac701579..b1163fdbb 100644
+index a53425b0a..c72dce201 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -147,6 +147,7 @@ ifdef(`distro_gentoo',`
+@@ -155,6 +155,7 @@ ifdef(`distro_gentoo',`
  /usr/bin(/.*)?				gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -27,5 +27,5 @@ index 9ac701579..b1163fdbb 100644
  /usr/bin/fish			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/git-shell		--	gen_context(system_u:object_r:shell_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index f039ebe..01c6801 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From e2a5ddc7235c9cf248a9d860ab8d0d71ec42e7a7 Mon Sep 17 00:00:00 2001
+From 62f52190b1ff3beac1b48e657484f6307b70b238 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
@@ -13,10 +13,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index d792422f5..a20f74820 100644
+index 5dfd6cd6b..5551ef07f 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -85,6 +85,7 @@ ifdef(`distro_redhat',`
+@@ -86,6 +86,7 @@ ifdef(`distro_redhat',`
  /run/dhcpcd(/.*)?		gen_context(system_u:object_r:dhcpc_runtime_t,s0)
  /run/netns	-d		gen_context(system_u:object_r:ifconfig_runtime_t,s0)
  /run/netns/[^/]+	--	<<none>>
@@ -25,5 +25,5 @@ index d792422f5..a20f74820 100644
  ifdef(`distro_gentoo',`
  /var/lib/dhcpc(/.*)?		gen_context(system_u:object_r:dhcpc_state_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 346b0db..506055d 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From 59b9c22802488a693d40e7570536cca89bdc58ee Mon Sep 17 00:00:00 2001
+From d26183bfc1fa9b9e93ac22707ef7b9b2f7df3238 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index eca178a2e..ddf5ecec2 100644
+index 9712f0f87..b3c2f56b4 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
@@ -24,5 +24,5 @@ index eca178a2e..ddf5ecec2 100644
  /usr/bin/pam_timestamp_check	--	gen_context(system_u:object_r:pam_exec_t,s0)
  /usr/bin/tcb_convert		--	gen_context(system_u:object_r:updpwd_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index d8c8489..7fef05d 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From 9a551208b7e1ebd451115ea36cde1536f34f3866 Mon Sep 17 00:00:00 2001
+From b01a876ff4dd5c8030e8239cff5278753de824a4 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
@@ -21,5 +21,5 @@ index 301965892..139485835 100644
  /usr/sbin/hwclock	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
 +/usr/sbin/hwclock\.util-linux	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 8d6b7b2..5e384b9 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From c67674b38368f5d584fd3013f0193b6e6e733a66 Mon Sep 17 00:00:00 2001
+From 8f867445e1e81f99a45f2791cfee6d197e4209e1 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
@@ -19,5 +19,5 @@ index e52fdfcf8..526b92ed2 100644
  /usr/bin/dmesg		--		gen_context(system_u:object_r:dmesg_exec_t,s0)
 +/usr/bin/dmesg\.util-linux		--		gen_context(system_u:object_r:dmesg_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 4660bca..9ca2d7b 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From 0493199f682a52c097ae81ac96118295e47bdf90 Mon Sep 17 00:00:00 2001
+From e8176157e818d2afda0c92933c089616f39799c6 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index 93bfa8d26..7b7e567f9 100644
+index bf47884f5..8fb419ee6 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
@@ -24,5 +24,5 @@ index 93bfa8d26..7b7e567f9 100644
  /usr/bin/ssh-keygen		--	gen_context(system_u:object_r:ssh_keygen_exec_t,s0)
  /usr/bin/sshd			--	gen_context(system_u:object_r:sshd_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 7c092ee..8b55a7a 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From 53c2af24e86b3ab9be5a982958bb0e5c9e8c1360 Mon Sep 17 00:00:00 2001
+From f66c77baa8d7cae2e71421554ce9fec52a666c3a Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
@@ -14,10 +14,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index a20f74820..6f2e3f8f0 100644
+index 5551ef07f..18707c702 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -45,6 +45,7 @@ ifdef(`distro_redhat',`
+@@ -46,6 +46,7 @@ ifdef(`distro_redhat',`
  /usr/bin/dhcpcd		        --	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/bin/ethtool		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ifconfig		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
@@ -25,7 +25,7 @@ index a20f74820..6f2e3f8f0 100644
  /usr/bin/ip			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_configure		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_interface		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-@@ -61,13 +62,16 @@ ifdef(`distro_redhat',`
+@@ -62,13 +63,16 @@ ifdef(`distro_redhat',`
  /usr/sbin/dhcpcd		--	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/sbin/ethtool		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/sbin/ifconfig		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
@@ -43,5 +43,5 @@ index a20f74820..6f2e3f8f0 100644
  /usr/sbin/tc			--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index f487090..69eac13 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 2df4a4620b74973ceafde3732273234de9668fe3 Mon Sep 17 00:00:00 2001
+From 05cfce6462a9b669d0e9c19e5054eed6eaee929b Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
@@ -23,5 +23,5 @@ index 7efcf71de..2f83019f0 100644
 +/usr/bin/cpio\.cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
  ')
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index c84de1b..268d066 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From 0d026ac95a9da5e345e5b7fbaded216396e12bde Mon Sep 17 00:00:00 2001
+From ade8050fdc8c309f8b92d118687bd97f5ca794f3 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
@@ -23,5 +23,5 @@ index 3375c9692..a9868cd58 100644
 +/usr/bin/su\.shadow		--	gen_context(system_u:object_r:su_exec_t,s0)
 +/usr/bin/su\.util-linux		--	gen_context(system_u:object_r:su_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 0ef343d..3463350 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 09de3f9093cde03bf906411403ff43a25290bd6b Mon Sep 17 00:00:00 2001
+From 1249ee744695066f00978af709e637dcf450efa9 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -14,10 +14,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 10 insertions(+)
 
 diff --git a/policy/modules/system/fstools.fc b/policy/modules/system/fstools.fc
-index 9064ab52e..5962e5736 100644
+index f12c3515b..e719d7a04 100644
 --- a/policy/modules/system/fstools.fc
 +++ b/policy/modules/system/fstools.fc
-@@ -57,7 +57,9 @@
+@@ -55,7 +55,9 @@
  /usr/sbin/addpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/badblocks		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/blkid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -27,13 +27,14 @@ index 9064ab52e..5962e5736 100644
  /usr/sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/delpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -70,10 +72,13 @@
+@@ -68,23 +70,29 @@
  /usr/sbin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/fdisk\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/findfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/findfs\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/sbin/fstrim		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fsck.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/gdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/hdparm		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -41,15 +42,13 @@ index 9064ab52e..5962e5736 100644
  /usr/sbin/install-mbr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/jfs_.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/losetup.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -81,13 +86,16 @@
- /usr/sbin/make_reiser4		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/sbin/lsraid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mkdosfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mke2fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/mke2fs\.e2fsprogs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mke4fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mkfs.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mkraid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mkreiserfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mkswap		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/mkswap\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/parted		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -58,7 +57,7 @@ index 9064ab52e..5962e5736 100644
  /usr/sbin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -97,8 +105,10 @@
+@@ -93,8 +101,10 @@
  /usr/sbin/sfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -70,5 +69,5 @@ index 9064ab52e..5962e5736 100644
  /usr/sbin/zhack			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/zinject		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index a483165..bc66308 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From a76963ea8a74c818bd03acae75ae86db59c366e7 Mon Sep 17 00:00:00 2001
+From 1e014179592a6987c0a122ab4a6ee9aa61c7fbd7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
@@ -27,10 +27,10 @@ index 2e47783c2..e359539be 100644
  /run/shutdown\.pid	--	gen_context(system_u:object_r:shutdown_runtime_t,s0)
  
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index b1163fdbb..1c2553d21 100644
+index c72dce201..a50256c13 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -156,6 +156,8 @@ ifdef(`distro_gentoo',`
+@@ -164,6 +164,8 @@ ifdef(`distro_gentoo',`
  /usr/bin/mkfs\.cramfs		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/bin/mksh			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/mountpoint		--	gen_context(system_u:object_r:bin_t,s0)
@@ -52,5 +52,5 @@ index 75c75e7d1..962f18099 100644
  /usr/sbin/upstart	--	gen_context(system_u:object_r:init_exec_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index 855446c..e059828 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From 19c91699eda904d2c377a29c62bdf6be1ebf59f7 Mon Sep 17 00:00:00 2001
+From d19a7e3c74f84b482612fc523eeea0d9d9263594 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
@@ -20,5 +20,5 @@ index ed472f095..2a852b0fd 100644
  /usr/sbin/brctl	--	gen_context(system_u:object_r:brctl_exec_t,s0)
 +/usr/sbin/brctl\.bridge-utils	--	gen_context(system_u:object_r:brctl_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index 220a9b8..972f0c1 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From 3b40ac147bc2e1a1d387d519fd1710e92d934b4e Mon Sep 17 00:00:00 2001
+From b378cd35ee983e30074f4cef81e512adc1ba8d14 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 1c2553d21..65178ba32 100644
+index a50256c13..5fd532202 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -312,6 +312,8 @@ ifdef(`distro_debian',`
+@@ -320,6 +320,8 @@ ifdef(`distro_debian',`
  /usr/sbin/insmod_ksymoops_clean	--	gen_context(system_u:object_r:bin_t,s0)
  /usr/sbin/mkfs\.cramfs		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/sbin/nologin		--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -24,5 +24,5 @@ index 1c2553d21..65178ba32 100644
  /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/sbin/smrsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 29a9a05..917dcc4 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From 07657262d8ac7304f8dd0224e3daaecc925d4392 Mon Sep 17 00:00:00 2001
+From fac8b484bd3b5cd3d1283a2ae04317f6e6d89bac Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
@@ -21,5 +21,5 @@ index fc8d58507..59e6e9601 100644
 +/usr/sbin/sulogin\.util-linux	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
  /usr/sbin/sushell	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index c16b3d0..4143b49 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From 85f3abe44a579ddff62fa3ef774c9d53c3bb35e4 Mon Sep 17 00:00:00 2001
+From 25ede8d1c8ac8618d10130957bfd9ca7029f7f88 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ntp.fc b/policy/modules/services/ntp.fc
-index 9243f3304..e13cf6a9b 100644
+index 7b55699ee..b55d5fb86 100644
 --- a/policy/modules/services/ntp.fc
 +++ b/policy/modules/services/ntp.fc
-@@ -25,6 +25,7 @@
+@@ -26,6 +26,7 @@
  /usr/lib/systemd/systemd-timesyncd	--	gen_context(system_u:object_r:ntpd_exec_t,s0)
  
  /usr/sbin/ntpd				--	gen_context(system_u:object_r:ntpd_exec_t,s0)
@@ -23,5 +23,5 @@ index 9243f3304..e13cf6a9b 100644
  /usr/sbin/sntp				--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index bcbc59f..9e88c22 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From b23752c14edcda3a5d25c386986cb2a53f68df71 Mon Sep 17 00:00:00 2001
+From 0707b5c142915d994b8cbc08d4d9659697c40ed7 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
@@ -46,5 +46,5 @@ index df21fcc78..ce0166edd 100644
  /var/log/kadmin\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
  /var/log/kadmind\.log.*	--	gen_context(system_u:object_r:kadmind_log_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index 111af65..5c62515 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From e86acf68aec0f34bd0d0e41cedbaf4e1584d1a74 Mon Sep 17 00:00:00 2001
+From adec1632a9c7d8f80d2f353c5d69cfba429d5e2e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
@@ -36,5 +36,5 @@ index 0a1d08d0f..65b202962 100644
  /run/openldap(/.*)?	gen_context(system_u:object_r:slapd_runtime_t,s0)
  /run/slapd.*	-s	gen_context(system_u:object_r:slapd_runtime_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index c5f190a..1408ab4 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From e237a9acdb30805eec7f7baea6265a4595f93b9d Mon Sep 17 00:00:00 2001
+From a6057afaeedbc4ed148f3554746aeecc6ee31e3a Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
@@ -33,5 +33,5 @@ index f31a52cf8..f9bf46870 100644
  /usr/share/jonas/pgsql(/.*)?		gen_context(system_u:object_r:postgresql_db_t,s0)
  ')
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch b/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
deleted file mode 100644
index 0ce9694..0000000
--- a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
+++ /dev/null
@@ -1,25 +0,0 @@
-From 83195f523c21392d9be0af8cd3bc358bd42f882c Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Fri, 15 Nov 2019 11:15:33 +0800
-Subject: [PATCH] fc/screen: apply policy to screen alternatives
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/apps/screen.fc | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/policy/modules/apps/screen.fc b/policy/modules/apps/screen.fc
-index e51e01d97..238dc263e 100644
---- a/policy/modules/apps/screen.fc
-+++ b/policy/modules/apps/screen.fc
-@@ -7,4 +7,5 @@ HOME_DIR/\.tmux\.conf	--	gen_context(system_u:object_r:screen_home_t,s0)
- /run/tmux(/.*)?			gen_context(system_u:object_r:screen_runtime_t,s0)
- 
- /usr/bin/screen		--	gen_context(system_u:object_r:screen_exec_t,s0)
-+/usr/bin/screen-.*		--	gen_context(system_u:object_r:screen_exec_t,s0)
- /usr/bin/tmux		--	gen_context(system_u:object_r:screen_exec_t,s0)
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
similarity index 97%
rename from recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
rename to recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index c4bcc75..8c2b6da 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 75bc058a2571dc61b74b18647fa0288b9c47d628 Mon Sep 17 00:00:00 2001
+From 94b6c8baa19eb3ac8eda4a9b4151dc3c69e432fc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
@@ -53,5 +53,5 @@ index 7209a8dd0..c9dc1f000 100644
  /usr/share/cracklib(/.*)?	gen_context(system_u:object_r:crack_db_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
rename to recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
index c06c824..e1a0eac 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From 5b7b58fb5b23b4ccc427233061ba816b45faaca3 Mon Sep 17 00:00:00 2001
+From f112cd85a2121fe84a4ace6b781dad5dc77ba5fe Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
@@ -23,5 +23,5 @@ index 116ea6421..53ff6137b 100644
  /usr/sbin/.*getty	--	gen_context(system_u:object_r:getty_exec_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
rename to recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
index 670446b..3239ce8 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 6e72fd53bbadf600c06c3f25dfd502e6a9c502fb Mon Sep 17 00:00:00 2001
+From 677a140a33f4abc1ef7a2baef768d50485180595 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
@@ -21,5 +21,5 @@ index f668cde9c..c4bc50984 100644
  
  /usr/sbin/vlock-main	--	gen_context(system_u:object_r:vlock_exec_t,s0)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
rename to recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 84af1fa..3c0b031 100644
--- a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 7f58d61471a45851dd162c2b4bd9733a5311c0b9 Mon Sep 17 00:00:00 2001
+From 4a1c5f7649d960a1a5456f84da1fcc88d992b155 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
@@ -34,7 +34,7 @@ index 382c067f9..0ecc5acc4 100644
  /usr/bin/rngd	--	gen_context(system_u:object_r:rngd_exec_t,s0)
  
 diff --git a/policy/modules/services/rpc.fc b/policy/modules/services/rpc.fc
-index 3b6d1c930..4949d995a 100644
+index fb579bc9d..12e086b8d 100644
 --- a/policy/modules/services/rpc.fc
 +++ b/policy/modules/services/rpc.fc
 @@ -2,7 +2,9 @@
@@ -48,7 +48,7 @@ index 3b6d1c930..4949d995a 100644
  
  /usr/bin/blkmapd	--	gen_context(system_u:object_r:blkmapd_exec_t,s0)
 diff --git a/policy/modules/system/logging.fc b/policy/modules/system/logging.fc
-index 3b0dea51b..0ce2bec4b 100644
+index 102a89e48..b10ea8acf 100644
 --- a/policy/modules/system/logging.fc
 +++ b/policy/modules/system/logging.fc
 @@ -24,6 +24,7 @@
@@ -60,5 +60,5 @@ index 3b0dea51b..0ce2bec4b 100644
  /usr/lib/systemd/systemd-kmsg-syslogd	--	gen_context(system_u:object_r:syslogd_exec_t,s0)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
rename to recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index a2a1de8..8c785e0 100644
--- a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From de259386cb52e44dd00534f598800a23be0d7689 Mon Sep 17 00:00:00 2001
+From 709df66b11b654fd15fcaa6c0ac5e39bedadde51 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -26,5 +26,5 @@ index 690007f22..f80499ebf 100644
 +# Add an aliase for it
 +/root /home/root
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
rename to recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
index 7aaf702..7d3b042 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 5147059bcfce76f04c4bacaadc4007588b6a722f Mon Sep 17 00:00:00 2001
+From 17aa22ea4681d38fe7a90c0a3a0a9b2181bd7f0b Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 8 insertions(+)
 
 diff --git a/policy/modules/system/logging.fc b/policy/modules/system/logging.fc
-index 0ce2bec4b..8957366b0 100644
+index b10ea8acf..6aa62b4ba 100644
 --- a/policy/modules/system/logging.fc
 +++ b/policy/modules/system/logging.fc
 @@ -53,6 +53,7 @@ ifdef(`distro_suse', `
@@ -30,7 +30,7 @@ index 0ce2bec4b..8957366b0 100644
  /var/log/dmesg		--	gen_context(system_u:object_r:var_log_t,s0)
  /var/log/syslog		--	gen_context(system_u:object_r:var_log_t,s0)
 diff --git a/policy/modules/system/logging.if b/policy/modules/system/logging.if
-index 7487a7053..6acf1f52b 100644
+index 499da83ba..ac05e206d 100644
 --- a/policy/modules/system/logging.if
 +++ b/policy/modules/system/logging.if
 @@ -1091,10 +1091,12 @@ interface(`logging_append_all_inherited_logs',`
@@ -87,5 +87,5 @@ index 7487a7053..6acf1f52b 100644
  
  ########################################
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
similarity index 87%
rename from recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
rename to recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 2b43530..90b95d4 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From e2ce1a7a491ee079b9e393ba6bc6c17d457959f4 Mon Sep 17 00:00:00 2001
+From bd0c6361b144e638039830a3a2eff4b05c36add6 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 11bbbc113..38e0b4766 100644
+index a2f35f278..11a0fad46 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -425,6 +425,7 @@ files_search_spool(syslogd_t)
+@@ -429,6 +429,7 @@ files_search_spool(syslogd_t)
  
  # Allow access for syslog-ng
  allow syslogd_t var_log_t:dir { create setattr };
@@ -30,5 +30,5 @@ index 11bbbc113..38e0b4766 100644
  # for systemd but can not be conditional
  files_runtime_filetrans(syslogd_t, syslogd_tmp_t, dir, "log")
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
similarity index 77%
rename from recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
rename to recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 6256789..7570ed8 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From da3cf0879a8e34996125871e8d1336726f715acb Mon Sep 17 00:00:00 2001
+From 87b66b35c6bebc4fe807f7d4020519df10af483f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 9 insertions(+)
 
 diff --git a/policy/modules/kernel/files.fc b/policy/modules/kernel/files.fc
-index b1728d37c..c5012e6b4 100644
+index d174f882c..d393a6bc2 100644
 --- a/policy/modules/kernel/files.fc
 +++ b/policy/modules/kernel/files.fc
-@@ -172,6 +172,7 @@ HOME_ROOT/lost\+found/.*	<<none>>
+@@ -167,6 +167,7 @@ HOME_ROOT/lost\+found/.*	<<none>>
  # /tmp
  #
  /tmp			-d	gen_context(system_u:object_r:tmp_t,s0-mls_systemhigh)
@@ -30,10 +30,10 @@ index b1728d37c..c5012e6b4 100644
  /tmp/\.journal			<<none>>
  
 diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
-index e1fafd4ab..dbd7efa60 100644
+index e55bf337e..5d67cae99 100644
 --- a/policy/modules/kernel/files.if
 +++ b/policy/modules/kernel/files.if
-@@ -4897,6 +4897,7 @@ interface(`files_search_tmp',`
+@@ -4970,6 +4970,7 @@ interface(`files_search_tmp',`
  	')
  
  	allow $1 tmp_t:dir search_dir_perms;
@@ -41,7 +41,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -4933,6 +4934,7 @@ interface(`files_list_tmp',`
+@@ -5006,6 +5007,7 @@ interface(`files_list_tmp',`
  	')
  
  	allow $1 tmp_t:dir list_dir_perms;
@@ -49,7 +49,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -4969,6 +4971,7 @@ interface(`files_delete_tmp_dir_entry',`
+@@ -5042,6 +5044,7 @@ interface(`files_delete_tmp_dir_entry',`
  	')
  
  	allow $1 tmp_t:dir del_entry_dir_perms;
@@ -57,7 +57,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -4987,6 +4990,7 @@ interface(`files_read_generic_tmp_files',`
+@@ -5060,6 +5063,7 @@ interface(`files_read_generic_tmp_files',`
  	')
  
  	read_files_pattern($1, tmp_t, tmp_t)
@@ -65,7 +65,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -5005,6 +5009,7 @@ interface(`files_manage_generic_tmp_dirs',`
+@@ -5078,6 +5082,7 @@ interface(`files_manage_generic_tmp_dirs',`
  	')
  
  	manage_dirs_pattern($1, tmp_t, tmp_t)
@@ -73,7 +73,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -5041,6 +5046,7 @@ interface(`files_manage_generic_tmp_files',`
+@@ -5114,6 +5119,7 @@ interface(`files_manage_generic_tmp_files',`
  	')
  
  	manage_files_pattern($1, tmp_t, tmp_t)
@@ -81,7 +81,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -5077,6 +5083,7 @@ interface(`files_rw_generic_tmp_sockets',`
+@@ -5150,6 +5156,7 @@ interface(`files_rw_generic_tmp_sockets',`
  	')
  
  	rw_sock_files_pattern($1, tmp_t, tmp_t)
@@ -89,7 +89,7 @@ index e1fafd4ab..dbd7efa60 100644
  ')
  
  ########################################
-@@ -5284,6 +5291,7 @@ interface(`files_tmp_filetrans',`
+@@ -5357,6 +5364,7 @@ interface(`files_tmp_filetrans',`
  	')
  
  	filetrans_pattern($1, tmp_t, $2, $3, $4)
@@ -98,5 +98,5 @@ index e1fafd4ab..dbd7efa60 100644
  
  ########################################
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
similarity index 76%
rename from recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
rename to recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
index b6ec45c..34e224e 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From 59c29aa28424cf61f6b71a9022dced52d5b58c8f Mon Sep 17 00:00:00 2001
+From a6cffb4673b5ea372f7aa0679e8d89cd97018d85 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 38e0b4766..a1912254e 100644
+index 11a0fad46..a1e4a5b8d 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -117,6 +117,7 @@ allow auditctl_t self:netlink_audit_socket nlmsg_readpriv;
+@@ -120,6 +120,7 @@ allow auditctl_t auditd_log_t:file read_file_perms;
  
  read_files_pattern(auditctl_t, auditd_etc_t, auditd_etc_t)
  allow auditctl_t auditd_etc_t:dir list_dir_perms;
@@ -28,15 +28,15 @@ index 38e0b4766..a1912254e 100644
  dontaudit auditctl_t auditd_etc_t:file map;
  
  corecmd_search_bin(auditctl_t)
-@@ -177,6 +178,7 @@ dontaudit auditd_t auditd_etc_t:file map;
- manage_files_pattern(auditd_t, auditd_log_t, auditd_log_t)
+@@ -180,6 +181,7 @@ dontaudit auditd_t auditd_etc_t:file map;
  allow auditd_t auditd_log_t:dir setattr;
+ allow auditd_t auditd_log_t:file { append_file_perms create_file_perms link read_file_perms rename_file_perms setattr_file_perms unlink };
  manage_lnk_files_pattern(auditd_t, auditd_log_t, auditd_log_t)
 +allow auditd_t var_log_t:lnk_file read_lnk_file_perms;
  allow auditd_t var_log_t:dir search_dir_perms;
  
- manage_files_pattern(auditd_t, auditd_runtime_t, auditd_runtime_t)
-@@ -306,6 +308,7 @@ optional_policy(`
+ manage_dirs_pattern(auditd_t, auditd_runtime_t, auditd_runtime_t)
+@@ -310,6 +312,7 @@ optional_policy(`
  allow audisp_remote_t self:capability { setpcap setuid };
  allow audisp_remote_t self:process { getcap setcap };
  allow audisp_remote_t self:tcp_socket create_socket_perms;
@@ -45,5 +45,5 @@ index 38e0b4766..a1912254e 100644
  
  manage_dirs_pattern(audisp_remote_t, audit_spool_t, audit_spool_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
similarity index 87%
rename from recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
rename to recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index 77d59b8..da62522 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From 81222e113818c210d4c2a65567d0b464f96b0523 Mon Sep 17 00:00:00 2001
+From fc37036aa30e58b4d9c75cbb412d6371212765b3 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/kernel/terminal.if b/policy/modules/kernel/terminal.if
-index 4db1fd773..f3431fa21 100644
+index 48310450b..fffebdb0c 100644
 --- a/policy/modules/kernel/terminal.if
 +++ b/policy/modules/kernel/terminal.if
-@@ -335,9 +335,12 @@ interface(`term_use_console',`
+@@ -391,9 +391,12 @@ interface(`term_use_console',`
  interface(`term_dontaudit_use_console',`
  	gen_require(`
  		type console_device_t;
@@ -34,5 +34,5 @@ index 4db1fd773..f3431fa21 100644
  
  ########################################
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
rename to recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
index 0ffd2f7..cbbe755 100644
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From 1c992963d7006927a79c9009c372ab9593b5bb95 Mon Sep 17 00:00:00 2001
+From cbf27ba4d70fdb9c4877929789311d3b25d7837f Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 523e49f14..e48a8c26f 100644
+index 4188c9547..cbc72d6a9 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
@@ -42,5 +42,5 @@ index 523e49f14..e48a8c26f 100644
  ## <desc>
  ## <p>
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
rename to recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
index 9c5b172..aba8479 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
@@ -1,4 +1,4 @@
-From 803bb22683f9265837d0a0713d1f49003eb33ac8 Mon Sep 17 00:00:00 2001
+From 70e8a8c6468a279b8ae38ff4a681255d05439c0a Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 30 Sep 2023 17:20:29 +0800
 Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index a1912254e..481ae9d14 100644
+index a1e4a5b8d..97b86b2a7 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -27,6 +27,10 @@ type auditd_log_t;
@@ -39,5 +39,5 @@ index a1912254e..481ae9d14 100644
  files_security_file(audit_spool_t)
  files_security_mountpoint(audit_spool_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch
rename to recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
index fb3146a..bd88d11 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From b2271a808dcc39a199729cbc3884577a5359bb63 Mon Sep 17 00:00:00 2001
+From 39b06488ae85aba2442f3eac2eb42b91edf5f285 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -26,15 +26,15 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/system/systemd.if    | 30 +++++++++++++++++++++++++++++
+ policy/modules/system/systemd.if    | 31 +++++++++++++++++++++++++++++
  policy/modules/system/userdomain.if |  4 ++++
- 2 files changed, 34 insertions(+)
+ 2 files changed, 35 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 0f92c23bd..1ae6195a1 100644
+index db6bd9752..64d83367d 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -236,6 +236,36 @@ template(`systemd_role_template',`
+@@ -267,6 +267,37 @@ template(`systemd_role_template',`
  	')
  ')
  
@@ -63,6 +63,7 @@ index 0f92c23bd..1ae6195a1 100644
 +		type $1_systemd_t;
 +	')
 +
++	allow $1_systemd_t self:process setsched;
 +	allow $1_systemd_t $3:process noatsecure;
 +	allow $1_systemd_t self:capability { mknod sys_admin };
 +	allow $1_systemd_t self:capability2 { bpf perfmon };
@@ -72,10 +73,10 @@ index 0f92c23bd..1ae6195a1 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 677bad480..d2e5feda7 100644
+index 0be775e9e..efa65779a 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1467,6 +1467,10 @@ template(`userdom_admin_user_template',`
+@@ -1480,6 +1480,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
@@ -87,5 +88,5 @@ index 677bad480..d2e5feda7 100644
  
  ########################################
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
deleted file mode 100644
index e0feada..0000000
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
+++ /dev/null
@@ -1,36 +0,0 @@
-From c89141ec6fc96e304a8dac16fa5f4e45fa802201 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Fri, 28 Oct 2022 11:56:09 +0800
-Subject: [PATCH] policy/modules/roles/sysadm: allow sysadm to use init file
- descriptors
-
-Root can not login via console without this.
-
-Fixes:
-avc: denied { use } for pid=323 comm="sh" path="/dev/tty1"
-dev="devtmpfs" ino=21 scontext=root:sysadm_r:sysadm_t
-tcontext=system_u:system_r:init_t tclass=fd permissive=0
-
-Upstream-Status: Pending
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/roles/sysadm.te | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index acf2c67ae..0c96829a9 100644
---- a/policy/modules/roles/sysadm.te
-+++ b/policy/modules/roles/sysadm.te
-@@ -95,6 +95,8 @@ ifdef(`init_systemd',`
- 	# LookupDynamicUserByUID on org.freedesktop.systemd1.
- 	init_dbus_chat(sysadm_t)
- 
-+	init_use_fds(sysadm_t)
-+
- 	# Allow sysadm to get the status of and set properties of other users,
- 	# sessions, and seats on the system.
- 	systemd_dbus_chat_logind(sysadm_t)
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
similarity index 89%
rename from recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch
rename to recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
index 8885851..496010b 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From 74f4dd3dfdd0356171a7ce08c5d5c797c57dbe4a Mon Sep 17 00:00:00 2001
+From d167a78e361bfd81bdda18692ef0e66a3921cc74 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,10 +21,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 481ae9d14..be602fc7f 100644
+index 97b86b2a7..45ed81867 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -402,6 +402,8 @@ optional_policy(`
+@@ -406,6 +406,8 @@ optional_policy(`
  # sys_admin for the integrated klog of syslog-ng and metalog
  # sys_nice for rsyslog
  allow syslogd_t self:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice sys_resource sys_tty_config };
@@ -34,5 +34,5 @@ index 481ae9d14..be602fc7f 100644
  dontaudit syslogd_t self:cap_userns { kill sys_ptrace };
  # setpgid for metalog
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch
rename to recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index b4b8291..bab51dd 100644
--- a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From 0047cbb8997d9d36613dcee9b60430fa44025713 Mon Sep 17 00:00:00 2001
+From ea19bb6f4c7d130f0b2d2c025b6359a5a7f82c83 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,10 +67,10 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index be602fc7f..dbb9c62c9 100644
+index 45ed81867..a3afe5525 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -491,6 +491,7 @@ files_read_kernel_symbol_table(syslogd_t)
+@@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
  files_var_lib_filetrans(syslogd_t, syslogd_var_lib_t, { file dir })
  
  fs_getattr_all_fs(syslogd_t)
@@ -79,10 +79,10 @@ index be602fc7f..dbb9c62c9 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e48a8c26f..23f7a6027 100644
+index cbc72d6a9..cbae29894 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1332,6 +1332,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1467,6 +1467,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
@@ -91,17 +91,17 @@ index e48a8c26f..23f7a6027 100644
  fs_read_nsfs_files(systemd_networkd_t)
  fs_watch_memory_pressure(systemd_networkd_t)
 diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
-index 620de7e2e..ccb073351 100644
+index e245a66a4..5cc9484eb 100644
 --- a/policy/modules/system/udev.te
 +++ b/policy/modules/system/udev.te
-@@ -142,6 +142,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
+@@ -144,6 +144,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
  
  fs_getattr_all_fs(udev_t)
  fs_list_inotifyfs(udev_t)
 +fs_list_tmpfs(udev_t)
  fs_read_cgroup_files(udev_t)
  fs_rw_anon_inodefs_files(udev_t)
- fs_search_tracefs(udev_t)
+ fs_list_tmpfs(udev_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch
rename to recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index a2238b5..605ed6c 100644
--- a/recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 975472091496c8f6ed6544dd307672ccb97cf958 Mon Sep 17 00:00:00 2001
+From 003ae9b4e2e4049a62745634a83ad3f95d2a7e9e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
@@ -35,5 +35,5 @@ index 0f38015b6..e3eee0590 100644
  ')
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch
rename to recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
index 0010a1f..7661870 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -1,4 +1,4 @@
-From 9627b5cad0230bc937ba1f2901985afbbc8fcff6 Mon Sep 17 00:00:00 2001
+From ec677f6cd1fd050e5f558aec6101296769d6bcee Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 09:54:06 +0800
 Subject: [PATCH] systemd: allow systemd-logind to inherit fds
@@ -35,10 +35,10 @@ index ebb7ef0e0..0398ce6fd 100644
  		allow $3 $1_su_t:process signal;
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 1ae6195a1..99318a3c2 100644
+index 64d83367d..e6aa112c0 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1439,6 +1439,24 @@ interface(`systemd_use_logind_fds',`
+@@ -1501,6 +1501,24 @@ interface(`systemd_use_logind_fds',`
  	allow $1 systemd_logind_t:fd use;
  ')
  
@@ -64,5 +64,5 @@ index 1ae6195a1..99318a3c2 100644
  ## <summary>
  ##      Watch logind sessions dirs.
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
rename to recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index 47209ea..c615c81 100644
--- a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From f3f3623bf112dee989cae09a5b9842c78655f220 Mon Sep 17 00:00:00 2001
+From ed34e4e062a23f11708c023b2daba4b83b74e23e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 23 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 65178ba32..c7e3d2dae 100644
+index 5fd532202..d51f266e5 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -241,6 +241,7 @@ ifdef(`distro_gentoo',`
+@@ -249,6 +249,7 @@ ifdef(`distro_gentoo',`
  /usr/lib/sftp-server		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/ssh(/.*)?			gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/sudo/sesh		--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -61,10 +61,10 @@ index 08ed91f19..0fa4cbf7d 100644
 +	read_lnk_files_pattern($1, bin_t, bin_t)
 +')
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 99318a3c2..7654d1076 100644
+index e6aa112c0..3f3426ebd 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -146,6 +146,7 @@ template(`systemd_role_template',`
+@@ -155,6 +155,7 @@ template(`systemd_role_template',`
  	userdom_exec_user_bin_files($1_systemd_t)
  
  	# user systemd-tmpfiles rules
@@ -73,10 +73,10 @@ index 99318a3c2..7654d1076 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 64f13e247..c605d58de 100644
+index cbae29894..7e39556b7 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1932,6 +1932,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2142,6 +2142,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
@@ -87,5 +87,5 @@ index 64f13e247..c605d58de 100644
  dev_manage_all_dev_nodes(systemd_tmpfiles_t)
  dev_read_urand(systemd_tmpfiles_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
new file mode 100644
index 0000000..6113588
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
@@ -0,0 +1,76 @@
+From 7049caea5b0a37084d144c37212f6da57b16e7df Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 26 Sep 2025 15:15:44 +0800
+Subject: [PATCH] systemd: fix for systemd-networkd and systemd-rfkill
+
+Fixes:
+avc:  denied  { sys_admin } for  pid=391 comm="systemd-network"
+capability=21
+scontext=system_u:system_r:systemd_networkd_t:s0-s15:c0.c1023
+tcontext=system_u:system_r:systemd_networkd_t:s0-s15:c0.c1023
+tclass=capability permissive=0
+
+avc:  denied  { getattr } for  pid=396 comm="systemd-network"
+path="/dev/sda2" dev="devtmpfs" ino=181
+scontext=system_u:system_r:systemd_networkd_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:fixed_disk_device_t:s15:c0.c1023
+tclass=blk_file permissive=0
+
+avc:  denied  { search } for  pid=396 comm="systemd-network"
+name="mount" dev="tmpfs" ino=58
+scontext=system_u:system_r:systemd_networkd_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:mount_runtime_t:s0 tclass=dir permissive=0
+
+avc:  denied  { sys_admin } for  pid=284 comm="systemd-rfkill"
+capability=21
+scontext=system_u:system_r:systemd_rfkill_t:s0-s15:c0.c1023
+tcontext=system_u:system_r:systemd_rfkill_t:s0-s15:c0.c1023
+tclass=capability permissive=0
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/systemd.te | 6 +++++-
+ 1 file changed, 5 insertions(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 7e39556b7..adcd931b7 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -1419,7 +1419,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
+ # networkd local policy
+ #
+ 
+-allow systemd_networkd_t self:capability { chown dac_override fowner net_admin net_raw setgid setpcap setuid };
++allow systemd_networkd_t self:capability { chown dac_override fowner net_admin net_raw setgid setpcap setuid sys_admin };
+ allow systemd_networkd_t self:netlink_generic_socket create_socket_perms;
+ allow systemd_networkd_t self:netlink_kobject_uevent_socket create_socket_perms;
+ allow systemd_networkd_t self:netlink_netfilter_socket create_socket_perms;
+@@ -1459,12 +1459,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
+ dev_read_urand(systemd_networkd_t)
+ dev_read_sysfs(systemd_networkd_t)
+ dev_write_kmsg(systemd_networkd_t)
++dev_dontaudit_getattr_all_chr_files(systemd_networkd_t)
++dev_dontaudit_getattr_all_blk_files(systemd_networkd_t)
+ 
+ files_read_etc_files(systemd_networkd_t)
+ files_read_etc_runtime_files(systemd_networkd_t)
+ files_watch_runtime_dirs(systemd_networkd_t)
+ files_watch_root_dirs(systemd_networkd_t)
+ files_list_runtime(systemd_networkd_t)
++files_dontaudit_search_all_dirs(systemd_networkd_t)
+ 
+ fs_getattr_all_fs(systemd_networkd_t)
+ fs_list_tmpfs(systemd_networkd_t)
+@@ -1893,6 +1896,7 @@ logging_send_syslog_msg(systemd_pstore_t)
+ # Rfkill local policy
+ #
+ 
++allow systemd_rfkill_t self:capability sys_admin;
+ allow systemd_rfkill_t self:netlink_kobject_uevent_socket create_socket_perms;
+ 
+ manage_dirs_pattern(systemd_rfkill_t, systemd_rfkill_var_lib_t, systemd_rfkill_var_lib_t)
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
similarity index 84%
rename from recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
rename to recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 43d4e83..8c0bc8d 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 87ebadc702f2e3de7c4a8470cffde09a53c8fb8f Mon Sep 17 00:00:00 2001
+From 2460a7db017d5bcbf53d1e2419ee9422f8de7271 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/mount.te b/policy/modules/system/mount.te
-index c5727585c..71ff4efd1 100644
+index 1417bcb27..f0a826a76 100644
 --- a/policy/modules/system/mount.te
 +++ b/policy/modules/system/mount.te
-@@ -119,6 +119,7 @@ fs_dontaudit_write_all_image_files(mount_t)
+@@ -120,6 +120,7 @@ fs_dontaudit_write_all_image_files(mount_t)
  
  mls_file_read_all_levels(mount_t)
  mls_file_write_all_levels(mount_t)
@@ -31,5 +31,5 @@ index c5727585c..71ff4efd1 100644
  selinux_get_enforce_mode(mount_t)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
rename to recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 079510c..5afa497 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From 4cb4afe1def20e106b0cbac0fb686c28a95ac6d7 Mon Sep 17 00:00:00 2001
+From f86a3f306eaa24038f9090e4f99b4f46914735d9 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index 0c96829a9..5fbcc7204 100644
+index 3a8242568..d783d4582 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
-@@ -48,6 +48,8 @@ logging_watch_all_logs(sysadm_t)
+@@ -57,6 +57,8 @@ logging_watch_all_logs(sysadm_t)
  logging_watch_audit_log(sysadm_t)
  
  mls_process_read_all_levels(sysadm_t)
@@ -36,5 +36,5 @@ index 0c96829a9..5fbcc7204 100644
  selinux_read_policy(sysadm_t)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
rename to recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index 63e32ec..dce8f1e 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From 7feb72e30444b314c0bf3ca400375b2486d0e7c9 Mon Sep 17 00:00:00 2001
+From adfe3ab856fa6a1650a47d5450080307aaf19e97 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 7 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 65c814a97..da264d081 100644
+index 26578a26d..74984078d 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -378,6 +378,8 @@ mls_process_read_all_levels(kernel_t)
+@@ -384,6 +384,8 @@ mls_process_read_all_levels(kernel_t)
  mls_process_write_all_levels(kernel_t)
  mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
@@ -44,5 +44,5 @@ index 137c21ece..d2ee1edcf 100644
  	term_dontaudit_use_unallocated_ttys(rpcbind_t)
  ')
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
rename to recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index 9f53ba7..a3b36a0 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 929d814365465704142aaa3eaa80abad6d03efde Mon Sep 17 00:00:00 2001
+From 00e1288cb8bd975c9252fd3eda97cbc3bb705de6 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
@@ -32,5 +32,5 @@ index f1da315a9..89478c38e 100644
  	seutil_sigchld_newrole(dmesg_t)
  ')
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 2073395..df316ce 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 6ebec2a77b771cfcac8a7320eae7a9abde7cfc3a Mon Sep 17 00:00:00 2001
+From 42dbcc5513da2e2f63ddc9af7b551b01244bdce5 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -59,10 +59,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index da264d081..e84bcf2b6 100644
+index 74984078d..a1fc34ca8 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -380,6 +380,8 @@ mls_file_write_all_levels(kernel_t)
+@@ -386,6 +386,8 @@ mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
  mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
@@ -72,5 +72,5 @@ index da264d081..e84bcf2b6 100644
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 89%
rename from recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 85095df..147ca29 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From 93936c7a0cf671f463b5d3360c6c906df4028e33 Mon Sep 17 00:00:00 2001
+From ccd95772201397f33dc4aa585d253a010a713d5f Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,10 +27,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 43d62b2e1..039272004 100644
+index 0772961ab..ad51a24ab 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -239,6 +239,10 @@ mls_process_write_all_levels(init_t)
+@@ -256,6 +256,10 @@ mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
  
@@ -42,5 +42,5 @@ index 43d62b2e1..039272004 100644
  # otherwise the call fails and sysvinit tries to load the policy
  # again when using the initramfs
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
rename to recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index fd4d1fe..2e1c99f 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From a698845641cf86d0cdcab4b014b14757fbc0a605 Mon Sep 17 00:00:00 2001
+From 86bb36e5b6dc2c1c20c30b569f7c2e8c1f680015 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index c605d58de..fb75c2f45 100644
+index adcd931b7..2595abc8b 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2024,6 +2024,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2241,6 +2241,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
@@ -59,5 +59,5 @@ index c605d58de..fb75c2f45 100644
  userdom_relabel_user_runtime_root_dirs(systemd_tmpfiles_t)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
similarity index 84%
rename from recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
rename to recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
index c8cf04a..560bc2d 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From f70cd58e286d417f9024b23056234038629bb75f Mon Sep 17 00:00:00 2001
+From d0a659f27ef2877a3d282fc90fe2e8035efa7d92 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,12 +43,12 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index fb75c2f45..45d4db784 100644
+index 2595abc8b..e4f53fe66 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -439,6 +439,9 @@ files_search_var_lib(systemd_backlight_t)
- fs_getattr_all_fs(systemd_backlight_t)
- fs_search_cgroup_dirs(systemd_backlight_t)
+@@ -463,6 +463,9 @@ optional_policy(`
+ 	unconfined_dbus_send(systemd_backlight_t)
+ ')
  
 +mls_file_read_to_clearance(systemd_backlight_t)
 +mls_file_write_to_clearance(systemd_backlight_t)
@@ -56,9 +56,9 @@ index fb75c2f45..45d4db784 100644
  #######################################
  #
  # Binfmt local policy
-@@ -616,6 +619,9 @@ term_use_unallocated_ttys(systemd_generator_t)
- 
- udev_read_runtime_files(systemd_generator_t)
+@@ -676,6 +679,9 @@ udev_read_runtime_files(systemd_generator_t)
+ # for systemd-getty-generator
+ userdom_use_user_ttys(systemd_generator_t)
  
 +mls_file_read_to_clearance(systemd_generator_t)
 +mls_file_write_to_clearance(systemd_generator_t)
@@ -66,9 +66,9 @@ index fb75c2f45..45d4db784 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1093,6 +1099,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+@@ -1196,6 +1202,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
- userdom_use_user_ttys(systemd_logind_t)
+ userdom_use_user_terminals(systemd_logind_t)
  
 +mls_file_read_all_levels(systemd_logind_t)
 +mls_file_write_all_levels(systemd_logind_t)
@@ -76,7 +76,7 @@ index fb75c2f45..45d4db784 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1722,6 +1731,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1920,6 +1929,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
@@ -87,5 +87,5 @@ index fb75c2f45..45d4db784 100644
  #
  # Resolved local policy
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
rename to recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index 4b70735..a96d5e3 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From 25be898844c76cba143de013c05966258e0ec98d Mon Sep 17 00:00:00 2001
+From 49eac86160aa1b5e587a62441b22a8c2fccab2af Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index dbb9c62c9..9659937fe 100644
+index a3afe5525..a2df275eb 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -495,6 +495,9 @@ fs_list_tmpfs(syslogd_t)
+@@ -499,6 +499,9 @@ fs_list_tmpfs(syslogd_t)
  fs_search_auto_mountpoints(syslogd_t)
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
@@ -32,5 +32,5 @@ index dbb9c62c9..9659937fe 100644
  term_write_console(syslogd_t)
  # Allow syslog to a terminal
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 179fc54..afced9e 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From ba07393b28fd2459a6ae7e4c50a48d1ee954360e Mon Sep 17 00:00:00 2001
+From b9be2d9790614d313fdf46d9e7cabaa47d7d3ea1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 039272004..0a7add4b7 100644
+index ad51a24ab..cd0e3171c 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -238,6 +238,7 @@ mls_file_write_all_levels(init_t)
+@@ -255,6 +255,7 @@ mls_file_write_all_levels(init_t)
  mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
@@ -29,5 +29,5 @@ index 039272004..0a7add4b7 100644
  # MLS trusted for lowering/raising the level of files
  mls_file_downgrade(init_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
rename to recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
index afce2c0..973c0f0 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From a01c52188566c4148862076dae90baa265e985df Mon Sep 17 00:00:00 2001
+From 3bca256a6b97562f9c75e03dd7e8e62077bc71e9 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 0a7add4b7..7df44cead 100644
+index cd0e3171c..c4c1a5323 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -244,6 +244,9 @@ mls_key_write_all_levels(init_t)
+@@ -261,6 +261,9 @@ mls_key_write_all_levels(init_t)
  mls_file_downgrade(init_t)
  mls_file_upgrade(init_t)
  
@@ -36,5 +36,5 @@ index 0a7add4b7..7df44cead 100644
  # otherwise the call fails and sysvinit tries to load the policy
  # again when using the initramfs
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
similarity index 87%
rename from recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
rename to recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index ce77779..9b1762c 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From dfc4e8ef225a6ce97ef4862b608228440d099863 Mon Sep 17 00:00:00 2001
+From 50037f06b0fecd6f8d0416832d18bbf8821a55dd Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 9659937fe..2c733c0f2 100644
+index a2df275eb..daaeefb64 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -236,6 +236,8 @@ miscfiles_read_localization(auditd_t)
+@@ -240,6 +240,8 @@ miscfiles_read_localization(auditd_t)
  
  mls_file_read_all_levels(auditd_t)
  mls_file_write_all_levels(auditd_t) # Need to be able to write to /var/run/ directory
@@ -35,5 +35,5 @@ index 9659937fe..2c733c0f2 100644
  seutil_dontaudit_read_config(auditd_t)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 83%
rename from recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index b0af22d..0a24032 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From f26d8ea933ef3f6fe72fbded8d1f6b683c135ab9 Mon Sep 17 00:00:00 2001
+From 2def1a0849bcef3099f50c99c12eb60974dc9c28 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index e84bcf2b6..987709345 100644
+index a1fc34ca8..7ec2aa471 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -382,6 +382,7 @@ mls_socket_write_all_levels(kernel_t)
+@@ -388,6 +388,7 @@ mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
  # https://bugzilla.redhat.com/show_bug.cgi?id=667370
  mls_file_downgrade(kernel_t)
@@ -27,5 +27,5 @@ index e84bcf2b6..987709345 100644
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
rename to recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index d415fa2..1bbeeb2 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 44aada7fe60d66a45fdcb9b1e5039365cf2b962b Mon Sep 17 00:00:00 2001
+From 66402eb7ea25179ba0e21267f0dea1b506a6ab26 Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
@@ -26,5 +26,5 @@ index 0a87a8d70..738badc52 100644
  selinux_compute_access_vector(setrans_t)
  
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
similarity index 82%
rename from recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
rename to recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index bd629fe..f7d13e1 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 115135e6809b715df2b382bf9e35eef3e09be311 Mon Sep 17 00:00:00 2001
+From 2a968f30e93462c5555277442b04f4abce3637ce Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,12 +24,12 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 7654d1076..22d5e2b18 100644
+index 3f3426ebd..bb32d1981 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -235,6 +235,9 @@ template(`systemd_role_template',`
- 		xdg_read_config_files($1_systemd_t)
- 		xdg_read_data_files($1_systemd_t)
+@@ -266,6 +266,9 @@ template(`systemd_role_template',`
+ 		xserver_read_xdm_state($1_systemd_t)
+ 		xserver_use_user_fonts($1_systemd_t)
  	')
 +
 +	mls_file_read_all_levels($1_systemd_t)
@@ -38,5 +38,5 @@ index 7654d1076..22d5e2b18 100644
  
  ######################################
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
rename to recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
index 256fa50..8a2cfef 100644
--- a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 17f0718ec39892d411d2cbe029864167d5d191a2 Mon Sep 17 00:00:00 2001
+From 71542a544be671d68d9041aa84282f53cae5d05d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 2c733c0f2..c758dbff0 100644
+index daaeefb64..4de798007 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -459,6 +459,8 @@ allow syslogd_t syslogd_runtime_t:file map;
+@@ -463,6 +463,8 @@ allow syslogd_t syslogd_runtime_t:file map;
  manage_files_pattern(syslogd_t, syslogd_runtime_t, syslogd_runtime_t)
  files_runtime_filetrans(syslogd_t, syslogd_runtime_t, file)
  
@@ -44,5 +44,5 @@ index 2c733c0f2..c758dbff0 100644
  kernel_read_network_state(syslogd_t)
  kernel_read_kernel_sysctls(syslogd_t)
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 736e67b..fd41f8a 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -37,42 +37,41 @@ SRC_URI += " \
         file://0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch \
         file://0020-fc-ldap-apply-policy-to-ldap-alternatives.patch \
         file://0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch \
-        file://0022-fc-screen-apply-policy-to-screen-alternatives.patch \
-        file://0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch \
-        file://0024-fc-getty-add-file-context-to-start_getty.patch \
-        file://0025-fc-vlock-apply-policy-to-vlock-alternatives.patch \
-        file://0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch \
-        file://0027-file_contexts.subs_dist-set-aliase-for-root-director.patch \
-        file://0028-policy-modules-system-logging-add-rules-for-the-syml.patch \
-        file://0029-policy-modules-system-logging-add-rules-for-syslogd-.patch \
-        file://0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch \
-        file://0031-policy-modules-system-logging-fix-auditd-startup-fai.patch \
-        file://0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
-        file://0033-policy-modules-system-systemd-enable-support-for-sys.patch \
-        file://0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
-        file://0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
-        file://0036-policy-modules-system-systemd-systemd-user-fixes.patch \
-        file://0037-policy-modules-system-logging-grant-getpcap-capabili.patch \
-        file://0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
-        file://0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
-        file://0040-systemd-allow-systemd-logind-to-inherit-fds.patch \
-        file://0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
-        file://0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
-        file://0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
-        file://0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
-        file://0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
-        file://0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
-        file://0049-policy-modules-system-systemd-systemd-make-systemd_-.patch \
-        file://0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
-        file://0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0052-policy-modules-system-init-all-init_t-to-read-any-le.patch \
-        file://0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
-        file://0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
-        file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
-        file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch \
+        file://0023-fc-getty-add-file-context-to-start_getty.patch \
+        file://0024-fc-vlock-apply-policy-to-vlock-alternatives.patch \
+        file://0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch \
+        file://0026-file_contexts.subs_dist-set-aliase-for-root-director.patch \
+        file://0027-policy-modules-system-logging-add-rules-for-the-syml.patch \
+        file://0028-policy-modules-system-logging-add-rules-for-syslogd-.patch \
+        file://0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch \
+        file://0030-policy-modules-system-logging-fix-auditd-startup-fai.patch \
+        file://0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
+        file://0032-policy-modules-system-systemd-enable-support-for-sys.patch \
+        file://0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
+        file://0034-policy-modules-system-systemd-systemd-user-fixes.patch \
+        file://0035-policy-modules-system-logging-grant-getpcap-capabili.patch \
+        file://0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
+        file://0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
+        file://0038-systemd-allow-systemd-logind-to-inherit-fds.patch \
+        file://0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
+        file://0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
+        file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
+        file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
+        file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
+        file://0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
+        file://0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
+        file://0048-policy-modules-system-systemd-systemd-make-systemd_-.patch \
+        file://0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
+        file://0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0051-policy-modules-system-init-all-init_t-to-read-any-le.patch \
+        file://0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
+        file://0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
+        file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
+        file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 955d160..40fca83 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20250213+git"
+PV = "2.20250923+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "353352e31f0d301e6c49db79a753c7d0179b46c2"
+SRCREV_refpolicy = "004ca3252282b52f525c24f3c874bf7ecf724be1"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


