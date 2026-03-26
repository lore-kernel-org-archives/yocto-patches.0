Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9C8109E547
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 04:11:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40465.1774498306113659949
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Mar 2026 21:11:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=SrLaPbc+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7545558680=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q3keNM2717040
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 21:11:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Coa/rxzS8rIPXKGAQFLXvp6iaYPHJ57rJnqcbPaBiXI=; b=SrLaPbc+HIcA
	0oYhg2ohs2PVKFe19haXw78CI6tPZOTzGPIw+LuOWmmXwxm5U26Ym47R4hRFCcwa
	fBlQNrX/xXTxupa+IpYEI6DiILKYqVMjc2Lr2mCTSoGiyE6DP+quGPc4T2RTTDZg
	mjmzsBJNFdzsTB1czFv2sym1a48yI9O7BsE+gm6uEh075eQqrfeECgPKsBJmxIZe
	pXuTm4PMTeZubCkm8k+nRelJVkgwFIal+qYdvzAaL2kPQm/8LOYSq6oh4GkRqb5U
	16FOfofyYh3Ms33Xs20zwUE/Ni5T1PRcRl9azuha4myMFcRUwsypBj0OYpNfsXSP
	gTuK2Rf3mA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1tucwp4h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 21:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UA6OWpMzywa3SyeGSHg5uDApV4cRuJRI00IUUcY/SEAgHBS4fcZi4zsZjEA+SxHC0F8RIroB4lsiPLtZRYvVgtFyvqogASCL4YzofD02h0SFn/p9meKP88Y6E9H5AOX3taJQYG29b6jP0j8Tct6YWcz8mM52E/NuB5kg1mmDM98q72y8gJzzyFAXs373i3p55VrR5d58TJsw1faTuFGVeqIOakKxMzCwAlXWrtTdYx19Eqe/h9ndlN+w3fxgHtZ8AzGcyd/Qri1rL1mxkdPii+RUo7QnYWepGY4CoYhgwQJggABVkKBSMMOtLkqY6yr3hN4u/7WAKP/dLbfmFH2Rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Coa/rxzS8rIPXKGAQFLXvp6iaYPHJ57rJnqcbPaBiXI=;
 b=bxEqpB48J+UCs/jUDdWWBBE+T7pbcqk9+5aKfHHcB3/c8I5dd0LoggRkvMEVScDjq42VgeA6N2W/sFvzYmYWGMxzfQH/hP5OJqlbaLoJKz3XDivzdA9dhLgugIS4yaD/JcjgXLr+O9RQW8OncppyFeGdETncqvnJckhkJEZX9CF8Gp0R0Zo8vW/Xy4XmTQzPXQf+4nJgTxqqzVvvJpLYimrqGDzntaESZVPR8y9ushWL2u/097SK/hlc6rylRaz4/A2+ntcsU9W3aLiCXgAL3LF+wsqmTjtDz8OlwN5t2WT347SvAAQJFQ9px2jOa3dTvGZ1zyXfh/ZHMqAeoCy7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by DS4PPFDA9EFDFDB.namprd11.prod.outlook.com (2603:10b6:f:fc02::55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 26 Mar
 2026 04:11:41 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 04:11:41 +0000
Message-ID: <e38ab632-69b6-4296-b679-0b60d79eca22@windriver.com>
Date: Thu, 26 Mar 2026 12:11:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][master][0/14] Upgrade
 tensorflow from 2.19.0 to 2.21.0
To: yocto-patches@lists.yoctoproject.org
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
 <CA+chaQe_-D3ei532xoP8UVqXE=KdQ0EtPkXwD_fqZZtdpOwwyw@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQe_-D3ei532xoP8UVqXE=KdQ0EtPkXwD_fqZZtdpOwwyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|DS4PPFDA9EFDFDB:EE_
X-MS-Office365-Filtering-Correlation-Id: f9962d09-0280-45af-229f-08de8aedc896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|4022899009|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	7aPVOywP3MMU9gtxMMOijjsJB9LJYk5cKLHLEJT3olKaZWK87FXilha/OYXAy85Rf33k8eLg3zgYhxKp8D6ydfnmCLh2m4e94+c5yeaE3cATLcz8t5xdayLiZBKW5G0+H4aZPiJDjnTZt+dXg2nAebzz4gZt5SHsZxiUt4D8bjGN+3qn7Rb3VE5x2EnmQaPxY551dh311LVSTGX2s6iLCzpodFwYwaqio53nKi2L7u41g7Gfzbfb922jdZaQV7S/wTceGRssQp9afv1gvUbpi4ykvZlo0quOYS5oESnawX25OzSRLPGS3aUCRVZzFu6zDo3wQwp0LsMQsxa8pxpYXvdgLJVWc3OusbikaQYnIpG/mPq25ZfJS9oi0Po7Z+sVwTY0BtDJQKURFXqKHeRGvJrOUSVh1j6Sf6WPYPll7sUV6fCb9RECsGOy3LRCCEnZDdIXvJq5UjOj1Xsx/cR3WGHs7YqqOPM23FQFfXba6zGXkIO29C0Pyhor3DE8MtnvetkGCG95dY9Ds1D8h3YGgAx8y4JceGUgMmoMMvh70iCrwTU/UcYz4p57v260c4DiPwSMYTYyToUXiARLavCJvgGMOaELwjkmuAAThRkQg+vIApd+v4oljwfX3m5v0dG4063CX4BmbkEzvAy+PlFf6IH+Q+uwCWG6vHw9m+8kd2/ykYzSYAY+GJxPbnsDWUIT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDlnYkwyd0w0ZmZJY1JzK01CMVZEZThEU3BDek5GYWVvNDFXRGFhNU4vM3BR?=
 =?utf-8?B?eFRZZE9nVUFhT3ZxZmJZaWJ1eEFDTWlRU1RPSEs4Q3N2aERxMHVuMG8zVWNm?=
 =?utf-8?B?eU9aQWpjWkhzaEF6T2h2YXJxUkM2VlVYZndvN2lsUEFuS2FFQzdZYlR4WEFj?=
 =?utf-8?B?cCtDbjNQdWNZYUVOM2wrK2pZK3F1c2lmT3c3L2tGTm0zMlVvTnNueXdVUlov?=
 =?utf-8?B?SzIwNWI2Y1BCd2hjeVRJYmdIMGJYOUJGMTR4YnlIR1RlWE5tWmtnQytGdHpq?=
 =?utf-8?B?bEdnMGkrVG5uYm9McU1JMlhEbWpWaTZ6dGoxT0tXS3U0MDBTUTBzV1I4UkM3?=
 =?utf-8?B?T1c4SU45Z3lSQURVdzlVNGJsMVBucmNsUjNQU2d3V0FqVkpFUXZYMlhiSDF4?=
 =?utf-8?B?aDJIZFJ5OGV3MnFUNXp0eTBSZFNtbUNkZDJLQi9jWnU2RVI3bkwvbkxRZXFi?=
 =?utf-8?B?ckVqSDFlR0tuTmRMVUFVTGhTblFjY2pzRHI3QXVqQlZodDE3Zi9EUURhczZD?=
 =?utf-8?B?TDlsWkJvalVSYWdxMGVMcTE2bks1SUtJYmZSNlQzeVBybWNQTTNOY3BsMWhZ?=
 =?utf-8?B?NDZIMWxrZnhHcURMa05SUEpsRnlyRnRMeEV0S2k2ckVrczFvSDRhZ21qL2t1?=
 =?utf-8?B?UTRCa2Y1WTI1ZVZsWGlEZGw2VU11bVNyUGd3cXBjZC9BRFViZjgzN1BDTXV2?=
 =?utf-8?B?SmZBR25EVWQ4VkVBNHRmWjRqMW1TRFhqaERKeHZpcCtmUUpBMkQxVTRaMTlX?=
 =?utf-8?B?RE1NZFczS3M5dUVVUGZPTmEwNjVqbUZzbXd1aHlOQkFkdUU4VVJXeTIxVmth?=
 =?utf-8?B?ODFVY2g5R2RMckcwWm5tNTUwZ29oODZDNlhIWmdoeXVlUFVOSmZYb3laZzlr?=
 =?utf-8?B?T3g5aXo4WnlFY0pjTWN6MzBCWDVPZXB4eVRHNTU0WXRZNTdUNlNIbXRVUWN4?=
 =?utf-8?B?SmQ4dnNtWjdFV1pYMEJ2VUhSRDZsdng5b0VGV25pNnF6TFRiZXJic2tPR2RQ?=
 =?utf-8?B?YUlTY2toUEF5QkJpY0dkcGxMOGNEUkRTS2kyWU5YeG5mYzBLa2phNm50ZGd6?=
 =?utf-8?B?VzJINkV6dmdWd1VXakVKTFlpRHRGSzRMUHRnTll4dTFmVVFBVlZKNHZwZVM4?=
 =?utf-8?B?V3JyNVFJaTZSVnpEbTZxeGRNb2lMQ3R3QnV5R2F1OFpUVmUwTjU2SjBXdUtB?=
 =?utf-8?B?L3pDQkxBZEIxWE5ERjZMbGtQMXR4RHc3V3Uxc2hQMGo2MzRDS3U4dVY5dWNP?=
 =?utf-8?B?Rm5EcVBRdGpKc3ZiUmlwSURoSi9NY3hwWnl6KzhseDEwZUlSdkt1ZkhDY3g5?=
 =?utf-8?B?cnJQckFOUW5WNU4vRWx5T3dUWWNyZEg2OFowMS9hd1hkYWM5dEpHYW5henUz?=
 =?utf-8?B?aCtJZ3pVR0kvWlgxVlE3ZlUxVEJpS2hxSVJBc1R3M2RPVEZTak5HTUFEVUs5?=
 =?utf-8?B?aFJYbDUyY2ZRYTBnVGIvTzZ3L1ExSzlQVDRhb0ZaUFMzWlAxOTdKNVI5dEpK?=
 =?utf-8?B?cTVkQXRTWldBT2V4dlp3SzRoMzJmQ29ZYnlEWWszckhLSG5FMHVDZmJQd2ZD?=
 =?utf-8?B?Qk1LVzR3dkRQbHBUOUcrRXR0YVFuL1VRWXhSY1A0c3RPelFBSUtuRjZQdTRk?=
 =?utf-8?B?aWxYc2J5Uk16RlY3a1pwb25TM1F6K2l0bEIycWZKczBWamZ4bVhyM01xa1di?=
 =?utf-8?B?TXZqUDR6N0h1L1dkd2dpTFJVOU5IcFFNSmZXUzU0UlRnMW84NWpGVjBhMjl6?=
 =?utf-8?B?NURoKzRyd3BvKzdDbW1zWGRmTkJZT0FHRGdkbjM5aEt2anV5NGFob3p6TUdy?=
 =?utf-8?B?emFtMHVUNjdHTzNBZ1VyNWZVdUJmUThyQ0haUjl4RzdvM1RMQzRmQS9iZmZm?=
 =?utf-8?B?K0JwOUNXWHBoa0hDSzdSWEt5Q2N2SVJJcTRSbWx4SVJWS0NrelFteTg1SkNz?=
 =?utf-8?B?ZDl2eW5MRklrelYxYmVkN051SXFIdjl6L1hmREE5WnB3N1lkZ29QZWR6Tjg5?=
 =?utf-8?B?TmRmNFdXaFNsaXkxNkxwM081WWE5YmhyUFc0OGNZUkhmZkpYWnQyK1d4OEJQ?=
 =?utf-8?B?YjVMTi93ckxmRlhoMXRMeEc5MC9mT2pwZGJJUDFkb3JodG82SkNWakwvMXhM?=
 =?utf-8?B?SU9KK3orTGRvSDEzM1V6M3NUaG5LL21rdU9HT0hXelVKN1pGSTZoTldiRlRJ?=
 =?utf-8?B?TTJzckw3VkRsSXViNVlUdVg5NmJUVzFUZmdXV3JidW4vYjdzQTA1TVk1Qit6?=
 =?utf-8?B?c01RWUV6a01NSUsvVU9sOTgzMExHWklIN2phcHk4cWczQU0vcjRpMlBsNkpJ?=
 =?utf-8?B?N2RTUWFadWdEeEtIWUo4endyM0crNkUwS2pFWWxvMUNMc2VjTi9sdz09?=
X-Exchange-RoutingPolicyChecked: 
	a+RMkkPr2fi02ASoq8JDSx5rcd27sx+2fYgGClq6eWVqxVnAB2f9ySxsmTb0wjMjlGz01lyz6hS3WPYKA60FaXgXYiPLYxCTYcrhKmvdzbP54qMh27HCk7AUcTuYw/YIgZ9dKg3z7sosjcDnv8bU3d32OCMfopRCMHrgoOflBY5vyJhaiu/TXsyNommZ+EjjaOOlnyvdsHX72uv6piTM3r5NwbmZ7WWQN9m7i+blyCMGG5iWNi35Ptx8VTvPcY+vznByEXJ0AulQsUfJvJcdTBZUSump4jPCDpDRT1IyCWlVmsCHPEWQxYGPgJxmR2g0w7AwJuuW20RU76X4SLf1fQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9962d09-0280-45af-229f-08de8aedc896
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 04:11:41.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsSMhUBUgr6u6O0qB4LalYB7/5m5JQV7PCBSRNLa6/CULx5d7G/aAn73PZKB8hVIqiR/G5kO5bkuFR8368Czqm15lv46tDhXjp+qP8RO6og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFDA9EFDFDB
X-Proofpoint-GUID: hZ6-YCryTsTnUNgWwymNeAvoH2ko65DA
X-Proofpoint-ORIG-GUID: hZ6-YCryTsTnUNgWwymNeAvoH2ko65DA
X-Authority-Analysis: v=2.4 cv=deCNHHXe c=1 sm=1 tr=0 ts=69c4b201 cx=c_pps
 a=hcnkadelB84e5vzkSSmvUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=Jwo5Om6_zlnLbLYMLfEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDAzMCBTYWx0ZWRfXy4cKntW9L4cy
 rX4FDyzNu2nNH/97tPB4zXiJCibO9iFjo6PlVuhsFiNA36IreqXxgkXd4JBthyYg64OkRlBJGTq
 7Rd3Nwg16cHode1H84o7RT1kXTQkS2ZP1ctV9rvicX/kwMhjFFEDFdDMhCRl5jAJGVRxbhe+A9q
 d4n3jMXk37QyXibr50cyZ8ojPRPgFsB/jpZTIYZRmvHvJskIqKjeQmCFHIb9zdyknXS2RpyAVrW
 ruT3y78HBFjtWoK9g+mtyckCmdliaYyMi1K/IdLDPwBdQJMTOX4vHNRxgNdPdFla8ol9IAPHaLn
 5LG+3px3Hai62pcC3Kp6qoOjYllNx/42vO9U4G53mSeJVVq2ImVdlM/tsgYdPh7yMLSY8wJ7phI
 vvnnm8IsFoN7xYN3aPmxCNYqTOGMT5G0Nv7rpqiuS6vzRaCB/B6vlgVXchRJXVSy3Lq0WSiPcnD
 xs8KKVyMRN7ITTO2aXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260030
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 62Q3keNM2717040
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 04:11:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3554

On 3/25/26 15:34, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Wed, Mar 25, 2026 at 3:17=E2=80=AFAM hongxu via lists.yoctoproject.o=
rg
> <hongxu.jia=3Dwindriver.com@lists.yoctoproject.org> wrote:
>> Summary: Upgrade meta-tensorflow from 2.19.0 to 2.21.0
> Thanks you, can you please push it to master-next or somewhere else to
> make it easier to test these changes in our CI as well? Or what's ETA
> for merging this to master (as it cannot be used with latest oe-core
> without wrynose in compatibility list)?

Merged to master to compit wrynose

//Hongxu

>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3552): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3552
> Mute This Topic: https://lists.yoctoproject.org/mt/118495505/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


