Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965F4C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:23:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.49723.1743081831167739925
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 06:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5181a5ef2b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBcHI4031145
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68nxb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDxsccehrlif58O8KYFqGairJfe4ujFSYNxfwi5Tde53rW8sR3OR71lYKM7XH5m3+V8HnJMfQL3NiVJ2hgTAZ91RyQjQSOt+dkO0GUoU9ujBapH2ow3tcSXcdh4MWQma0BU+WB4hirXf2roXJF3C+d88sBo8mKtrMPofsOQ7nemwb2br8oOpEO4NiDoVFStRCi/08p8RI7aWIhqa9pTHn3HiIvIF9zGBw4P/gX4bHjOtXq1BnyOjSHdFKW4iwF8TAsldJdICY5v0pdfoLHmCp1TgI3YG4BhxnLZ/fGsSCEOQXeIwc++5ohXvMC73BSsG5u8T4ZlaD341x0quajGeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoY7kR/tfqKTu5w09+n1yQRMWHc0odIUByJ5XaVHJ8E=;
 b=jY0Q9q2MDYC5MSZpeGX8HjGYsKZHWz93zoDs+JsXKxuiSaZ9kBImz8a6xEjuMURB4kdbKj7anp4qVt2mobawSsMp0mTKdHoKCrgmOV/5Q6t3uFg/pGcQPOXIFsostd5rs3punHXxQ9OQaWK3QLp4aIvfVjBwp++7vleu1OpLSiJBbU+CxQTWixv5mVwZhcRdh/RqTRKSkPwB8sHeO5oKL4Dfq4IhfZxUBlIFcNmLJQ44acpOXYL/9fqqScZaD5cNndUG6DZTvSJCj8SQUZOjTs/V6wiElYikV592Cjsj+hgBwh0vKWokcN/JgfXYa3D7CmSsHVg8CZsfdW8EBPW65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:23:47 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:23:47 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/5] sssd: upgrade 2.9.2 -> 2.10.2
Date: Thu, 27 Mar 2025 21:23:26 +0800
Message-Id: <20250327132327.3477926-4-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250327132327.3477926-1-yi.zhao@windriver.com>
References: <20250327132327.3477926-1-yi.zhao@windriver.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c21a20-8b1a-45cc-7756-08dd6d329af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TURtc1VMc28rM1V6MHMvRzFQd09jaHVrUTdyTWRRbk1FeTA1WXRIYW5rUHJY?=
 =?utf-8?B?Ykp0SWFDN01XR0g2SzFSbVFIam0wcGN0aGJ6aTF4SWFVT2FLbTZrNHRoNGU1?=
 =?utf-8?B?TGx2bWh4YXBETXYxM0VOdE5zcDFMNUY1N2I5c3Q2bDhCaVY0cUJUKzVjMjNt?=
 =?utf-8?B?amI5elBGYmlETVpRZVdwdnZRUis2eVZrVW5sL0lGTnNRdDFmWHRyemRpak4x?=
 =?utf-8?B?RUtzaUdOL1EyblVtcFJOZERzdVNlOHlDbjBXMDVjN1VXWHlGZHQ4Uzd6MGZJ?=
 =?utf-8?B?ckFEV0Q5a0IyRXVKY1pxZUR6U3BtbmV2TTVjTmxqYzArdHFUN0U5YzJjNnAz?=
 =?utf-8?B?VEZ2OVpwMXRNb1AvbSt2UnhaVXU5Ymd4UUw5NWpacG4ySUdDOEdBb3cyK0NS?=
 =?utf-8?B?cCtsVVpmMFlpVFNxNVJISG11ZVBVbnVxY1hLc3Z5L2JINGR4NmxvaGo3alo2?=
 =?utf-8?B?dDUwTHJBWHIvR2gwZ2N2UHUxQmlncmZCL1I5NW5SaW82bjZTbzhKZFZqRkRL?=
 =?utf-8?B?NnNESzhHbFRwMTlJaXdKWGZpTDZLakVVeklhQWxmWXlwYm56NW94d0dsM3VQ?=
 =?utf-8?B?MmlwRG1LeXZrajZUVlExMmU2bWVySmEvdVd2cklRcHdNZGwrenp5Z0thNE9q?=
 =?utf-8?B?UmtWSmkvVWMxNEh6cU9RVkxobUdlVGZyVGlaSTR1akcreWJBa1ZJUTZVQnVZ?=
 =?utf-8?B?SktxcTh3UlNTd3JTTUd6Z0hRRGVSZThsbXJTOXRlRkZQZ1BGeThsa1BhNFRj?=
 =?utf-8?B?dnQycWlGRlQ3Znl5S2dmdUdTRWQ2cng2YW1DRGg0TlFsclp3cHJRWVBxM2cw?=
 =?utf-8?B?MFhNNzJ3emtKYmQ0Q2tnTSsvM043Wlp6U1MveFdpOHU0MDRCM0R5UUdjNnRj?=
 =?utf-8?B?OU1TSDhXdHVVTFJKaS9CR2dmMDByaTlSdlg3WTJKandDUS8wWDJaN2tMVTY1?=
 =?utf-8?B?Z2ZOUUdvTzl1NEdlYW5CYkkxOHJDdGdybUtiOThjLzVnN29xVGc5Y2xLV3Yr?=
 =?utf-8?B?UTNPeUZWTzNPWjFWRmNBdUlJV09qcHg1MnFsa01qcHQrNWp5SVdkODdUYk9J?=
 =?utf-8?B?ZWdPMFNqQ2NKWnVGZkNmT1dVeFhnaVRNem1OWnI5RjRWcDBxdDgrZU1HTSt0?=
 =?utf-8?B?V1N6MGtTKzB1TWUwazk2c0I0WVB2a0dXdkZ0YUhiSUd2NnNtbENxOVp1cyt4?=
 =?utf-8?B?MllMaU53Znl5N0xjMW8yQzlickYxV2dyOGZPOFhLQVJUbHJQdzlySWpMYUtK?=
 =?utf-8?B?NEp2U3M3SnhWM0ZNa1BQWGtmWGxXSElLMWx0R1pyaGN1TDFGTDkraEd0WGhn?=
 =?utf-8?B?cWNGSDJUYkZmMnBobk5DQmNuMzUwbkR1OG5YQUs0QSt0aGJsSmRWSzIvdHVs?=
 =?utf-8?B?SlpzT3JWdXhSdWJxWmszMTBRVW8xQVAyQXg1elBnSml6MndkY1RTSU1MMEpi?=
 =?utf-8?B?dWFlRnN0M0NGMTZ5Wk5WQzVWem5iYlBNUXhDYmc0cWNNSzUzYkhmL2k4bmxx?=
 =?utf-8?B?b2lnYzQwTnJNcUdwVkJ1WW51QlpUWk5kalkvZWZjQVp0QzRzS2ExUzAvQ0xN?=
 =?utf-8?B?M2w5d0lVeGo0Umt2ZGlCeWZ1U2I2MWt4MVFqaW5EVnRBZ0JjOWR6eEJCek1p?=
 =?utf-8?B?NXhNWHlFcHFDUERuQzZTVnhQaENYTHgyY0pIT283c0ZZcm5TYU5UVVhkT3Jz?=
 =?utf-8?B?eFdZWUdlR29CeTAyQmNUTzdrNHF1RkNQWGJISGs1THlXS2doeDRTNlRIc0Ft?=
 =?utf-8?B?QWxVTmprbUx5SE9qRmNydFZyQkJQTGpKUHdLbU9Bc1h0NG11eXE4UWVSNC8x?=
 =?utf-8?B?QVU5d05lQkRabklKa01yc0JUZVBIRUJpQ2dHcTBXNmI4aUZldEt0dUw1SkFi?=
 =?utf-8?B?Y2djbWticjhCNG0yTjNwV21vaW9qVmVra2QrWHFwQTMrUFE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEwxKzgvemlvWjBhS05YM2xyNk5DOHhSM2p0VUZWeG93bm9DaGo2WmdIWDJI?=
 =?utf-8?B?YmdxZTJJUmhWakZIZ0J6aTFLeVd0dUtQYmJFaEdEK0N3cTQ3OE1iYXB5OWQv?=
 =?utf-8?B?MXQybkkyanlORTd1QlgwWU5GaWp2YmRJMDNOQ3I5VWJBYmVDRXZoNGdraGxY?=
 =?utf-8?B?aTRjM3JvNHQ4TXd2c0hiTWxURTdKT3MwRHAweVRLUlpkYVl6K1JOZlFrS21R?=
 =?utf-8?B?NW9qSEVXY2gwL3lrRU1KR1ZRWmpISHIvYVBndTlEVXZUYk5BRnNpL3Ywa3dM?=
 =?utf-8?B?cU1oVS9NaFdFMlNHNk1SUXdHb3FPeWlYUVZJNmVBVGVwazVzeWZrMHJNQVQv?=
 =?utf-8?B?SldydWdhWWlEa2ZEM0hGaVU2SnorcTR2dlVZMDA1ZGNITFpZNXZ3amQzdnll?=
 =?utf-8?B?dGt4dzViNDQxVitrRUc1amNTMjQ3emphdWJHdURQSDRkeHMxeEF3UWNNY25w?=
 =?utf-8?B?L3NicHNsODRTVmRveGRqbVZCVlNaZExsM0F2OWtMZ0NqNlFMRXBnQU1mOGFX?=
 =?utf-8?B?TUpOZzZkblRiNHlScUxyMURQNU5Ub0dteCsva2QwZFRudG1qTzBvQVo5WFoy?=
 =?utf-8?B?WFdNeGN2TFFQUVVKekJIVnJ0THowWEdWamJ3bDBIQStyU0t2TzVPeXozbTdl?=
 =?utf-8?B?VUh0WFZEMlV4QW5SakViM2lLMUNucElxbWtYM0Z6b2pESmhRZFBwNEpMTHQz?=
 =?utf-8?B?b2U3MXM5MW9mM2I4MTdtRHJiR2tpTXVVQmxsbkluZjByNW1wTEpSVEFlM0RW?=
 =?utf-8?B?S2o3MEVuNGJsOEpram1Tb1RUZXoyQWNxZGpGdFlvQlk1VjN5K2Q0bC9XS0Ry?=
 =?utf-8?B?MU9VMzdONjRqQ2ZwNFM1aDJaNGlBLzE2MEEvc1oreGs5Uy8rU3FLWUduYSt1?=
 =?utf-8?B?eFk0ZjgrNjdGa3BCVk9wUmFyWk5pZHZyRU9kSUl3VnVEc1ZuN05DQUFndm1k?=
 =?utf-8?B?Tm9qWHFjSTJJdUZwMHo5OStvNXQwaE1XNW1pTmdpMk5iNU5KdUZDckZiTkNk?=
 =?utf-8?B?K0d0SFpzYlNoYVl3eEFQY3E0MFJEbFRSUnRXRnR6cVZPMlRvYjh3NjJOU2Ry?=
 =?utf-8?B?WDFWY0F0UVBwblVLVmY4Q0RXU0QvZ1lxYnFNMlEybWxrRWZGcTNYYkxUc3RO?=
 =?utf-8?B?cU1TMmdQWjB1WWFJMVhHcEUzMkh5bm53TndsNDg2RW4rSTN5RkpEcmpOVWVk?=
 =?utf-8?B?RFVvbHlOQXA2cUJIaGVQaGNKV0VTMGNTcktTa29VaC9aOUJ3QXYydW1pZVcw?=
 =?utf-8?B?d0F6c2N4Q3hVbUU1YzlNbVpjUlM0ZE5sd0FWY1ZQYzRzNXM1YldUblZNdU1l?=
 =?utf-8?B?R3doVVNZVUNzN3VRYUIzSEZaZXRoZHFwOSt6RWpUN3RyQWpRdk1IVjRXSzY2?=
 =?utf-8?B?S0NiV01zT0Z2YTZ0UkU0LzBEUEFvT0JlV1BHQnBUNHg1ekIwZlRTRXZHSUJl?=
 =?utf-8?B?VXJrYXlvQW1EQXFFcGplYmlDRE1ZWHJoR2s1L1J6SUdQcldLTzhTZ05sdWtW?=
 =?utf-8?B?cVVBMVRiemd4UndTYURXSzEzRDRzTnBGVUxMb0dIZzNqR0FJczRtZTd5clY2?=
 =?utf-8?B?S09DTzVuVTVtQ2h2V2VVZWoxdWRVTHVNSmhyc0tjZ3R0dS8rZ0tuMXNvMmY2?=
 =?utf-8?B?bm0rNlR6MHk5RVBRYngyWHhOT21QNG82M3UrYmxPTi93NVRwbjNZUVpTM05q?=
 =?utf-8?B?cHZlTEU3a25kQXlJVFh0SGNheXBITVpKWmt4YzBCUDg0Yzd1RTBhVFNIRytl?=
 =?utf-8?B?UmJSaDk0aDEzVVhISis1cDJINEg4UTdsenNPNVdmWkd2dklHVWUwL0o4Ulpv?=
 =?utf-8?B?Q3BDWjNrTVRYUUp6SWZubjZBamNEK1luM1pxbHRrSWRoYWhnUFB1TEtGNzZJ?=
 =?utf-8?B?c2o0cVpxYU1uWG9hQ2w1elE0eUtXMHFLcjBwTEhRS1Rwc1A2MjV3MEdUZURj?=
 =?utf-8?B?aXJ2UUlQWHdRT1JJdjVpQWQ4NkdYY0JZekNpaWJNbkhsRkh6NmZmMS93SWQ5?=
 =?utf-8?B?bk5rcXZUc2FxdWNDa1QyV1hLdy92SmR3ZGVCVTU2VDVkUS9Jd29GTldYbk5I?=
 =?utf-8?B?cjlBWHdpV3F5VDNyaHJpemVEVXdZVVZCLzBUSk5MUVorWDhXazU2WVo4bk9u?=
 =?utf-8?Q?y3fXBNQPBnPWL+bkvsR3/KhYl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c21a20-8b1a-45cc-7756-08dd6d329af9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:23:47.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOg3j339lbaNbb4JAa5ZfodAUhgjwjCjXlj87FIDahw/sFHQbfmNIQysMzFY5qn+0/sjF3bchPmQeC2VYWl+wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-Proofpoint-ORIG-GUID: KHbl4Hau4Qd6Kmt1ZIAruw3wIZO_8hF0
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e55166 cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=NEAV23lmAAAA:8 a=ArOQHuw0AAAA:8 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=2V6DY6BgAAAA:8 a=fk1lIlRQAAAA:8 a=Uvb3nusRVCz4S-CZC-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=DB1PmDU-bksA:10 a=sD7ozVhDsUP0bFIHhcxq:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=ldqKKs2zR4t-S6fqr-1n:22 a=U75ogvRika4pmaD_UPO0:22
X-Proofpoint-GUID: KHbl4Hau4Qd6Kmt1ZIAruw3wIZO_8hF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270093
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 52RBcHI4031145
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1269

ChangeLog:
https://github.com/SSSD/sssd/releases/tag/2.10.2

* Drop backport patches.
* Update sssd.conf and volatile files.
* Drop PACKAGECONFIG[infopipe] as it has been removed upstream.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../0001-sssctl-add-error-analyzer.patch      | 318 ------------------
 .../sssd/files/CVE-2023-3758.patch            | 219 ------------
 .../recipes-security/sssd/files/sssd.conf     |   3 +-
 .../sssd/files/volatiles.99_sssd              |   1 -
 .../sssd/{sssd_2.9.2.bb =3D> sssd_2.10.2.bb}    |  36 +-
 5 files changed, 18 insertions(+), 559 deletions(-)
 delete mode 100644 dynamic-layers/networking-layer/recipes-security/sssd=
/files/0001-sssctl-add-error-analyzer.patch
 delete mode 100644 dynamic-layers/networking-layer/recipes-security/sssd=
/files/CVE-2023-3758.patch
 delete mode 100644 dynamic-layers/networking-layer/recipes-security/sssd=
/files/volatiles.99_sssd
 rename dynamic-layers/networking-layer/recipes-security/sssd/{sssd_2.9.2=
.bb =3D> sssd_2.10.2.bb} (84%)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
0001-sssctl-add-error-analyzer.patch b/dynamic-layers/networking-layer/re=
cipes-security/sssd/files/0001-sssctl-add-error-analyzer.patch
deleted file mode 100644
index 6880405..0000000
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/0001-ss=
sctl-add-error-analyzer.patch
+++ /dev/null
@@ -1,318 +0,0 @@
-Backport patch to fix interpreter of sss_analyze.
-
-Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/ed3726c]
-
-Signed-off-by: Kai Kang <kai.kang@windriver.com>
-
-From ed3726c37fe07aab788404bfa2f9003db15f4210 Mon Sep 17 00:00:00 2001
-From: roy214 <abroy@redhat.com>
-Date: Tue, 25 Apr 2023 20:01:24 +0530
-Subject: [PATCH] sssctl: add error analyzer
-MIME-Version: 1.0
-Content-Type: text/plain; charset=3DUTF-8
-Content-Transfer-Encoding: 8bit
-
-Also removing unused variable and import.
-
-Reviewed-by: Justin Stephenson <jstephen@redhat.com>
-Reviewed-by: Tom=C3=A1=C5=A1 Halman <thalman@redhat.com>
----
- src/tools/analyzer/Makefile.am        |  2 +
- src/tools/analyzer/modules/error.py   | 61 +++++++++++++++++++++++++++
- src/tools/analyzer/modules/request.py | 54 +++++-------------------
- src/tools/analyzer/sss_analyze        |  2 +-
- src/tools/analyzer/sss_analyze.py     |  3 ++
- src/tools/analyzer/util.py            | 44 +++++++++++++++++++
- 6 files changed, 121 insertions(+), 45 deletions(-)
- create mode 100644 src/tools/analyzer/modules/error.py
- create mode 100644 src/tools/analyzer/util.py
-
-diff --git a/src/tools/analyzer/Makefile.am b/src/tools/analyzer/Makefil=
e.am
-index b40043d043..7692af8528 100644
---- a/src/tools/analyzer/Makefile.am
-+++ b/src/tools/analyzer/Makefile.am
-@@ -13,10 +13,12 @@ dist_pkgpython_DATA =3D \
-     source_reader.py \
-     parser.py \
-     sss_analyze.py \
-+    util.py \
-     $(NULL)
-=20
- modulesdir =3D $(pkgpythondir)/modules
- dist_modules_DATA =3D \
-     modules/__init__.py \
-     modules/request.py \
-+    modules/error.py \
-     $(NULL)
-diff --git a/src/tools/analyzer/modules/error.py b/src/tools/analyzer/mo=
dules/error.py
-new file mode 100644
-index 0000000000..71173670c5
---- /dev/null
-+++ b/src/tools/analyzer/modules/error.py
-@@ -0,0 +1,61 @@
-+from sssd import util
-+from sssd.parser import SubparsersAction
-+from sssd import sss_analyze
-+
-+class ErrorAnalyzer:
-+    """
-+    An error analyzer module, list if there is any error reported by ss=
sd_be
-+    """
-+    module_parser =3D None
-+    print_opts =3D []
-+
-+    def print_module_help(self, args):
-+        """
-+        Print the module parser help output
-+
-+        Args:
-+            args (Namespace): argparse parsed arguments
-+        """
-+        self.module_parser.print_help()
-+
-+    def setup_args(self, parser_grp, cli):
-+        """
-+        Setup module parser, subcommands, and options
-+
-+        Args:
-+            parser_grp (argparse.Action): Parser group to nest
-+               module and subcommands under
-+        """
-+        desc =3D "Analyze error check module"
-+        self.module_parser =3D parser_grp.add_parser('error',
-+                                                   description=3Ddesc,
-+                                                   help=3D'Error checke=
r')
-+
-+        subparser =3D self.module_parser.add_subparsers(title=3DNone,
-+                                                      dest=3D'subparser=
',
-+                                                      action=3DSubparse=
rsAction,
-+                                                      metavar=3D'COMMAN=
DS')
-+
-+        subcmd_grp =3D subparser.add_parser_group('Operation Modes')
-+        cli.add_subcommand(subcmd_grp, 'list', 'Print error messages fo=
und in backend',
-+                           self.print_error, self.print_opts)
-+
-+        self.module_parser.set_defaults(func=3Dself.print_module_help)
-+
-+        return self.module_parser
-+
-+    def print_error(self, args):
-+        err =3D 0
-+        utl =3D util.Utils()
-+        source =3D utl.load(args)
-+        component =3D source.Component.BE
-+        source.set_component(component, False)
-+        patterns =3D ['sdap_async_sys_connect request failed', 'termina=
ted by own WATCHDOG',
-+            'ldap_sasl_interactive_bind_s failed', 'Communication with =
KDC timed out', 'SSSD is offline', 'Backend is offline',
-+            'tsig verify failure', 'ldap_install_tls failed', 's2n exop=
 request failed']
-+        for line in utl.matched_line(source, patterns):
-+            err +=3D1
-+            print(line)
-+        if err > 0:
-+            print("For possible solutions please refer to https://sssd.=
io/troubleshooting/errors.html")
-+        return
-diff --git a/src/tools/analyzer/modules/request.py b/src/tools/analyzer/=
modules/request.py
-index d661dddb84..e4d5f060c7 100644
---- a/src/tools/analyzer/modules/request.py
-+++ b/src/tools/analyzer/modules/request.py
-@@ -1,6 +1,6 @@
- import re
- import logging
--
-+from sssd import util
- from sssd.parser import SubparsersAction
- from sssd.parser import Option
-=20
-@@ -38,7 +38,6 @@ def print_module_help(self, args):
-     def setup_args(self, parser_grp, cli):
-         """
-         Setup module parser, subcommands, and options
--
-         Args:
-             parser_grp (argparse.Action): Parser group to nest
-                module and subcommands under
-@@ -63,42 +62,6 @@ def setup_args(self, parser_grp, cli):
-=20
-         return self.module_parser
-=20
--    def load(self, args):
--        """
--        Load the appropriate source reader.
--
--        Args:
--            args (Namespace): argparse parsed arguments
--
--        Returns:
--            Instantiated source object
--        """
--        if args.source =3D=3D "journald":
--            from sssd.source_journald import Journald
--            source =3D Journald()
--        else:
--            from sssd.source_files import Files
--            source =3D Files(args.logdir)
--        return source
--
--    def matched_line(self, source, patterns):
--        """
--        Yield lines which match any number of patterns (OR) in
--        provided patterns list.
--
--        Args:
--            source (Reader): source Reader object
--        Yields:
--            lines matching the provided pattern(s)
--        """
--        for line in source:
--            for pattern in patterns:
--                re_obj =3D re.compile(pattern)
--                if re_obj.search(line):
--                    if line.startswith('   *  '):
--                        continue
--                    yield line
--
-     def get_linked_ids(self, source, pattern, regex):
-         """
-         Retrieve list of associated REQ_TRACE ids. Filter
-@@ -114,8 +77,9 @@ def get_linked_ids(self, source, pattern, regex):
-         Returns:
-             List of linked ids discovered
-         """
-+        utl =3D util.Utils()
-         linked_ids =3D []
--        for match in self.matched_line(source, pattern):
-+        for match in utl.matched_line(source, pattern):
-             id_re =3D re.compile(regex)
-             match =3D id_re.search(match)
-             if match:
-@@ -250,7 +214,8 @@ def list_requests(self, args):
-         Args:
-             args (Namespace):  populated argparse namespace
-         """
--        source =3D self.load(args)
-+        utl =3D util.Utils()
-+        source =3D utl.load(args)
-         component =3D source.Component.NSS
-         resp =3D "nss"
-         # Log messages matching the following regex patterns contain
-@@ -266,7 +231,7 @@ def list_requests(self, args):
-         if args.verbose:
-             self.print_formatted_verbose(source)
-         else:
--            for line in self.matched_line(source, patterns):
-+            for line in utl.matched_line(source, patterns):
-                 if type(source).__name__ =3D=3D 'Journald':
-                     print(line)
-                 else:
-@@ -279,7 +244,8 @@ def track_request(self, args):
-         Args:
-             args (Namespace):  populated argparse namespace
-         """
--        source =3D self.load(args)
-+        utl =3D util.Utils()
-+        source =3D utl.load(args)
-         cid =3D args.cid
-         resp_results =3D False
-         be_results =3D False
-@@ -294,7 +260,7 @@ def track_request(self, args):
-         logger.info(f"******** Checking {resp} responder for Client ID"
-                     f" {cid} *******")
-         source.set_component(component, args.child)
--        for match in self.matched_line(source, pattern):
-+        for match in utl.matched_line(source, pattern):
-             resp_results =3D self.consume_line(match, source, args.merg=
e)
-=20
-         logger.info(f"********* Checking Backend for Client ID {cid} **=
******")
-@@ -307,7 +273,7 @@ def track_request(self, args):
-         pattern.clear()
-         [pattern.append(f'\\{id}') for id in be_ids]
-=20
--        for match in self.matched_line(source, pattern):
-+        for match in utl.matched_line(source, pattern):
-             be_results =3D self.consume_line(match, source, args.merge)
-=20
-         if args.merge:
-diff --git a/src/tools/analyzer/sss_analyze b/src/tools/analyzer/sss_ana=
lyze
-index 3f1beaf38b..6d4b5b30c6 100755
---- a/src/tools/analyzer/sss_analyze
-+++ b/src/tools/analyzer/sss_analyze
-@@ -1,4 +1,4 @@
--#!/usr/bin/env python
-+#!/usr/bin/env python3
-=20
- from sssd import sss_analyze
-=20
-diff --git a/src/tools/analyzer/sss_analyze.py b/src/tools/analyzer/sss_=
analyze.py
-index 18b998f380..dafc84fc03 100644
---- a/src/tools/analyzer/sss_analyze.py
-+++ b/src/tools/analyzer/sss_analyze.py
-@@ -1,6 +1,7 @@
- import argparse
-=20
- from sssd.modules import request
-+from sssd.modules import error
- from sssd.parser import SubparsersAction
-=20
-=20
-@@ -55,9 +56,11 @@ def load_modules(self, parser, parser_grp):
-         """
-         # Currently only the 'request' module exists
-         req =3D request.RequestAnalyzer()
-+        err =3D error.ErrorAnalyzer()
-         cli =3D Analyzer()
-=20
-         req.setup_args(parser_grp, cli)
-+        err.setup_args(parser_grp, cli)
-=20
-     def setup_args(self):
-         """
-diff --git a/src/tools/analyzer/util.py b/src/tools/analyzer/util.py
-new file mode 100644
-index 0000000000..2a8d153a71
---- /dev/null
-+++ b/src/tools/analyzer/util.py
-@@ -0,0 +1,44 @@
-+import re
-+import logging
-+
-+from sssd.source_files import Files
-+from sssd.source_journald import Journald
-+
-+logger =3D logging.getLogger()
-+
-+
-+class Utils:
-+
-+    def load(self, args):
-+        """
-+        Load the appropriate source reader.
-+
-+        Args:
-+            args (Namespace): argparse parsed arguments
-+
-+        Returns:
-+            Instantiated source object
-+        """
-+        if args.source =3D=3D "journald":
-+            source =3D Journald()
-+        else:
-+            source =3D Files(args.logdir)
-+        return source
-+
-+    def matched_line(self, source, patterns):
-+        """
-+        Yield lines which match any number of patterns (OR) in
-+        provided patterns list.
-+
-+        Args:
-+            source (Reader): source Reader object
-+        Yields:
-+            lines matching the provided pattern(s)
-+        """
-+        for line in source:
-+            for pattern in patterns:
-+                re_obj =3D re.compile(pattern)
-+                if re_obj.search(line):
-+                    if line.startswith('   *  '):
-+                        continue
-+                    yield line
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
CVE-2023-3758.patch b/dynamic-layers/networking-layer/recipes-security/ss=
sd/files/CVE-2023-3758.patch
deleted file mode 100644
index 1e9fca5..0000000
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-202=
3-3758.patch
+++ /dev/null
@@ -1,219 +0,0 @@
-From f4ebe1408e0bc67abfbfb5f0ca2ea13803b36726 Mon Sep 17 00:00:00 2001
-From: Sumit Bose <sbose@redhat.com>
-Date: Wed, 8 Nov 2023 14:50:24 +0100
-Subject: [PATCH] ad-gpo: use hash to store intermediate results
-
-Currently after the evaluation of a single GPO file the intermediate
-results are stored in the cache and this cache entry is updated until
-all applicable GPO files are evaluated. Finally the data in the cache is
-used to make the decision of access is granted or rejected.
-
-If there are two or more access-control request running in parallel one
-request might overwrite the cache object with intermediate data while
-another request reads the cached data for the access decision and as a
-result will do this decision based on intermediate data.
-
-To avoid this the intermediate results are not stored in the cache
-anymore but in hash tables which are specific to the request. Only the
-final result is written to the cache to have it available for offline
-authentication.
-
-Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
-Reviewed-by: Tom=C3=A1=C5=A1 Halman <thalman@redhat.com>
-(cherry picked from commit d7db7971682da2dbf7642ac94940d6b0577ec35a)
-
-Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/f4ebe1408=
e0bc67abfbfb5f0ca2ea13803b36726]
-CVE: CVE-2023-3758
-Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
-
----
- src/providers/ad/ad_gpo.c | 116 +++++++++++++++++++++++++++++++++-----
- 1 file changed, 102 insertions(+), 14 deletions(-)
-
-diff --git a/src/providers/ad/ad_gpo.c b/src/providers/ad/ad_gpo.c
-index 44e9cbb..cec0cb4 100644
---- a/src/providers/ad/ad_gpo.c
-+++ b/src/providers/ad/ad_gpo.c
-@@ -1317,6 +1317,33 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx=
,
-     return ret;
- }
-
-+static errno_t
-+add_result_to_hash(hash_table_t *hash, const char *key, char *value)
-+{
-+    int hret;
-+    hash_key_t k;
-+    hash_value_t v;
-+
-+    if (hash =3D=3D NULL || key =3D=3D NULL || value =3D=3D NULL) {
-+        return EINVAL;
-+    }
-+
-+    k.type =3D HASH_KEY_CONST_STRING;
-+    k.c_str =3D key;
-+
-+    v.type =3D HASH_VALUE_PTR;
-+    v.ptr =3D value;
-+
-+    hret =3D hash_enter(hash, &k, &v);
-+    if (hret !=3D HASH_SUCCESS) {
-+        DEBUG(SSSDBG_OP_FAILURE, "Failed to add [%s][%s] to hash: [%s].=
\n",
-+                                 key, value, hash_error_string(hret));
-+        return EIO;
-+    }
-+
-+    return EOK;
-+}
-+
- /*
-  * This function parses the cse-specific (GP_EXT_GUID_SECURITY) filenam=
e,
-  * and stores the allow_key and deny_key of all of the gpo_map_types pr=
esent
-@@ -1324,6 +1351,7 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx,
-  */
- static errno_t
- ad_gpo_store_policy_settings(struct sss_domain_info *domain,
-+                             hash_table_t *allow_maps, hash_table_t *de=
ny_maps,
-                              const char *filename)
- {
-     struct ini_cfgfile *file_ctx =3D NULL;
-@@ -1457,14 +1485,14 @@ ad_gpo_store_policy_settings(struct sss_domain_i=
nfo *domain,
-                 goto done;
-             } else if (ret !=3D ENOENT) {
-                 const char *value =3D allow_value ? allow_value : empty=
_val;
--                ret =3D sysdb_gpo_store_gpo_result_setting(domain,
--                                                         allow_key,
--                                                         value);
-+                ret =3D add_result_to_hash(allow_maps, allow_key,
-+                                         talloc_strdup(allow_maps, valu=
e));
-                 if (ret !=3D EOK) {
--                    DEBUG(SSSDBG_CRIT_FAILURE,
--                          "sysdb_gpo_store_gpo_result_setting failed fo=
r key:"
--                          "'%s' value:'%s' [%d][%s]\n", allow_key, allo=
w_value,
--                          ret, sss_strerror(ret));
-+                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s]=
 "
-+                                               "value: [%s] to allow ma=
ps "
-+                                               "[%d][%s].\n",
-+                                               allow_key, value, ret,
-+                                               sss_strerror(ret));
-                     goto done;
-                 }
-             }
-@@ -1484,14 +1512,14 @@ ad_gpo_store_policy_settings(struct sss_domain_i=
nfo *domain,
-                 goto done;
-             } else if (ret !=3D ENOENT) {
-                 const char *value =3D deny_value ? deny_value : empty_v=
al;
--                ret =3D sysdb_gpo_store_gpo_result_setting(domain,
--                                                         deny_key,
--                                                         value);
-+                ret =3D add_result_to_hash(deny_maps, deny_key,
-+                                         talloc_strdup(deny_maps, value=
));
-                 if (ret !=3D EOK) {
--                    DEBUG(SSSDBG_CRIT_FAILURE,
--                          "sysdb_gpo_store_gpo_result_setting failed fo=
r key:"
--                          "'%s' value:'%s' [%d][%s]\n", deny_key, deny_=
value,
--                          ret, sss_strerror(ret));
-+                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s]=
 "
-+                                               "value: [%s] to deny map=
s "
-+                                               "[%d][%s].\n",
-+                                               deny_key, value, ret,
-+                                               sss_strerror(ret));
-                     goto done;
-                 }
-             }
-@@ -1784,6 +1812,8 @@ struct ad_gpo_access_state {
-     int num_cse_filtered_gpos;
-     int cse_gpo_index;
-     const char *ad_domain;
-+    hash_table_t *allow_maps;
-+    hash_table_t *deny_maps;
- };
-
- static void ad_gpo_connect_done(struct tevent_req *subreq);
-@@ -1906,6 +1936,19 @@ ad_gpo_access_send(TALLOC_CTX *mem_ctx,
-         goto immediately;
-     }
-
-+    ret =3D sss_hash_create(state, 0, &state->allow_maps);
-+    if (ret !=3D EOK) {
-+        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create allow maps "
-+              "hash table [%d]: %s\n", ret, sss_strerror(ret));
-+        goto immediately;
-+    }
-+
-+    ret =3D sss_hash_create(state, 0, &state->deny_maps);
-+    if (ret !=3D EOK) {
-+        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create deny maps "
-+              "hash table [%d]: %s\n", ret, sss_strerror(ret));
-+        goto immediately;
-+    }
-
-     subreq =3D sdap_id_op_connect_send(state->sdap_op, state, &ret);
-     if (subreq =3D=3D NULL) {
-@@ -2725,6 +2768,43 @@ ad_gpo_cse_step(struct tevent_req *req)
-     return EAGAIN;
- }
-
-+static errno_t
-+store_hash_maps_in_cache(struct sss_domain_info *domain,
-+                         hash_table_t *allow_maps, hash_table_t *deny_m=
aps)
-+{
-+    int ret;
-+    struct hash_iter_context_t *iter;
-+    hash_entry_t *entry;
-+    size_t c;
-+    hash_table_t *hash_list[] =3D { allow_maps, deny_maps, NULL};
-+
-+
-+    for (c =3D 0; hash_list[c] !=3D NULL; c++) {
-+        iter =3D new_hash_iter_context(hash_list[c]);
-+        if (iter =3D=3D NULL) {
-+            DEBUG(SSSDBG_OP_FAILURE, "Failed to create hash iterator.\n=
");
-+            return EINVAL;
-+        }
-+
-+        while ((entry =3D iter->next(iter)) !=3D NULL) {
-+            ret =3D sysdb_gpo_store_gpo_result_setting(domain,
-+                                                     entry->key.c_str,
-+                                                     entry->value.ptr);
-+            if (ret !=3D EOK) {
-+                free(iter);
-+                DEBUG(SSSDBG_OP_FAILURE,
-+                      "sysdb_gpo_store_gpo_result_setting failed for ke=
y:"
-+                      "[%s] value:[%s] [%d][%s]\n", entry->key.c_str,
-+                      (char *) entry->value.ptr, ret, sss_strerror(ret)=
);
-+                return ret;
-+            }
-+        }
-+        talloc_free(iter);
-+    }
-+
-+    return EOK;
-+}
-+
- /*
-  * This cse-specific function (GP_EXT_GUID_SECURITY) increments the
-  * cse_gpo_index until the policy settings for all applicable GPOs have=
 been
-@@ -2766,6 +2846,7 @@ ad_gpo_cse_done(struct tevent_req *subreq)
-      * (as part of the GPO Result object in the sysdb cache).
-      */
-     ret =3D ad_gpo_store_policy_settings(state->host_domain,
-+                                       state->allow_maps, state->deny_m=
aps,
-                                        cse_filtered_gpo->policy_filenam=
e);
-     if (ret !=3D EOK && ret !=3D ENOENT) {
-         DEBUG(SSSDBG_OP_FAILURE,
-@@ -2779,6 +2860,13 @@ ad_gpo_cse_done(struct tevent_req *subreq)
-
-     if (ret =3D=3D EOK) {
-         /* ret is EOK only after all GPO policy files have been downloa=
ded */
-+        ret =3D store_hash_maps_in_cache(state->host_domain,
-+                                       state->allow_maps, state->deny_m=
aps);
-+        if (ret !=3D EOK) {
-+            DEBUG(SSSDBG_OP_FAILURE, "Failed to store evaluated GPO map=
s "
-+                                     "[%d][%s].\n", ret, sss_strerror(r=
et));
-+            goto done;
-+        }
-         ret =3D ad_gpo_perform_hbac_processing(state,
-                                              state->gpo_mode,
-                                              state->gpo_map_type,
---
-2.25.1
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
sssd.conf b/dynamic-layers/networking-layer/recipes-security/sssd/files/s=
ssd.conf
index 1e8b537..2c9c6fc 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/sssd.co=
nf
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/sssd.co=
nf
@@ -7,7 +7,8 @@ domains =3D shadowutils
 [pam]
=20
 [domain/shadowutils]
-id_provider =3D files
+id_provider =3D proxy
+proxy_lib_name =3D files
=20
 auth_provider =3D proxy
 proxy_pam_target =3D sssd-shadowutils
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/=
volatiles.99_sssd b/dynamic-layers/networking-layer/recipes-security/sssd=
/files/volatiles.99_sssd
deleted file mode 100644
index 2a82413..0000000
--- a/dynamic-layers/networking-layer/recipes-security/sssd/files/volatil=
es.99_sssd
+++ /dev/null
@@ -1 +0,0 @@
-d root root 0750 /var/log/sssd none
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2=
.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10=
.2.bb
similarity index 84%
rename from dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.=
9.2.bb
rename to dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10=
.2.bb
index f35d0c8..0ed62b8 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.10.2.b=
b
@@ -18,16 +18,13 @@ DEPENDS +=3D "${@bb.utils.contains('PACKAGECONFIG', '=
nss', '', \
=20
 SRC_URI =3D "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.=
tar.gz \
            file://sssd.conf \
-           file://volatiles.99_sssd \
            file://no_gen.patch \
            file://fix_gid.patch \
            file://drop_ntpdate_chk.patch \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
-           file://0001-sssctl-add-error-analyzer.patch \
-           file://CVE-2023-3758.patch \
            "
-SRC_URI[sha256sum] =3D "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d=
4e22d93bb6f762ba"
+SRC_URI[sha256sum] =3D "e8aa5e6b48ae465bea7064048715ce7e9c53b50ec6a9c693=
04f59e0d35be40ff"
=20
 UPSTREAM_CHECK_URI =3D "https://github.com/SSSD/${BPN}/releases"
=20
@@ -42,24 +39,23 @@ CACHED_CONFIGUREVARS =3D "ac_cv_member_struct_ldap_co=
nncb_lc_arg=3Dno \
     ac_cv_prog_HAVE_PYTHON3=3Dyes \
     "
=20
-PACKAGECONFIG ?=3D "nss autofs sudo infopipe"
+PACKAGECONFIG ?=3D "nss autofs sudo"
 PACKAGECONFIG +=3D "${@bb.utils.contains('DISTRO_FEATURES', 'selinux', '=
selinux', '', d)}"
 PACKAGECONFIG +=3D "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '=
systemd', '', d)}"
=20
 PACKAGECONFIG[autofs] =3D "--with-autofs, --with-autofs=3Dno"
 PACKAGECONFIG[crypto] =3D ", , libcrypto"
 PACKAGECONFIG[curl] =3D "--with-kcm, --without-kcm, curl jansson"
-PACKAGECONFIG[infopipe] =3D "--with-infopipe, --with-infopipe=3Dno, "
 PACKAGECONFIG[manpages] =3D "--with-manpages, --with-manpages=3Dno, libx=
slt-native docbook-xml-dtd4-native docbook-xsl-stylesheets-native"
 PACKAGECONFIG[nl] =3D "--with-libnl, --with-libnl=3Dno, libnl"
 PACKAGECONFIG[nss] =3D ", ,nss,"
 PACKAGECONFIG[oidc_child] =3D "--with-oidc-child, --without-oidc-child"
 PACKAGECONFIG[python3] =3D "--with-python3-bindings, --without-python3-b=
indings python3dir=3D${PYTHON_SITEPACKAGES_DIR}, python3-setuptools-nativ=
e"
 PACKAGECONFIG[samba] =3D "--with-samba, --with-samba=3Dno, samba"
-PACKAGECONFIG[selinux] =3D "--with-selinux, --with-selinux=3Dno --with-s=
emanage=3Dno, libselinux"
+PACKAGECONFIG[selinux] =3D "--with-selinux, --with-selinux=3Dno, libseli=
nux"
 PACKAGECONFIG[ssh] =3D "--with-ssh, --with-ssh=3Dno, "
 PACKAGECONFIG[sudo] =3D "--with-sudo, --with-sudo=3Dno, "
-PACKAGECONFIG[systemd] =3D "--with-initscript=3Dsystemd,--with-initscrip=
t=3Dsysv,,python3-systemd"
+PACKAGECONFIG[systemd] =3D "--with-initscript=3Dsystemd --with-systemdun=
itdir=3D${systemd_system_unitdir} --with-systemdconfdir=3D${sysconfdir}/s=
ystemd/system, --with-initscript=3Dsysv,,python3-systemd"
=20
 EXTRA_OECONF +=3D " \
     --disable-cifs-idmap-plugin \
@@ -68,11 +64,11 @@ EXTRA_OECONF +=3D " \
     --without-python2-bindings \
     --enable-pammoddir=3D${base_libdir}/security \
     --with-xml-catalog-path=3D${STAGING_ETCDIR_NATIVE}/xml/catalog \
-    --with-pid-path=3D/run \
+    --with-pid-path=3D/run/sssd \
     --with-os=3Dfedora \
 "
=20
-do_configure:prepend() {
+do_configure:prepend () {
     mkdir -p ${AUTOTOOLS_AUXDIR}/build
     cp ${STAGING_DATADIR_NATIVE}/gettext/config.rpath ${AUTOTOOLS_AUXDIR=
}/build/
=20
@@ -84,6 +80,7 @@ do_compile:prepend () {
      sed -i -e "s/__useconds_t/useconds_t/g" ${S}/src/tools/tools_mc_uti=
l.c
      echo '#define NSUPDATE_PATH "${bindir}"' >> ${B}/config.h
 }
+
 do_install () {
     oe_runmake install  DESTDIR=3D"${D}"
     rmdir --ignore-fail-on-non-empty "${D}/${bindir}"
@@ -99,12 +96,14 @@ do_install () {
=20
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false=
', d)}; then
         install -d ${D}${sysconfdir}/tmpfiles.d
-        echo "d /var/log/sssd 0750 - - - -" > ${D}${sysconfdir}/tmpfiles=
.d/sss.conf
+        echo "d /var/log/sssd 0750 ${SSSD_UID} ${SSSD_GID} - -" > ${D}${=
sysconfdir}/tmpfiles.d/sssd.conf
+        echo "d /run/sssd 0750 ${SSSD_UID} ${SSSD_GID} - -" >> ${D}${sys=
confdir}/tmpfiles.d/sssd.conf
     fi
=20
     if [ "${@bb.utils.filter('DISTRO_FEATURES', 'sysvinit', d)}" ]; then
         install -d ${D}${sysconfdir}/default/volatiles
-        echo "d ${SSSD_UID}:${SSSD_GID} 0755 ${localstatedir}/log/${BPN}=
 none" > ${D}${sysconfdir}/default/volatiles/99_${BPN}
+        echo "d ${SSSD_UID}:${SSSD_GID} 0750 ${localstatedir}/log/sssd n=
one" > ${D}${sysconfdir}/default/volatiles/99_sssd
+        echo "d ${SSSD_UID}:${SSSD_GID} 0750 ${localstatedir}/run/sssd n=
one" >> ${D}${sysconfdir}/default/volatiles/99_sssd
     fi
=20
     if ${@bb.utils.contains('PACKAGECONFIG', 'python3', 'true', 'false',=
 d)}; then
@@ -112,15 +111,13 @@ do_install () {
     fi
=20
     # Remove /run as it is created on startup
-    rm -rf ${D}/run
-
-    rm -f ${D}${systemd_system_unitdir}/sssd-secrets.*
+    rm -rf ${D}/run ${D}/var/run
 }
=20
 pkg_postinst_ontarget:${PN} () {
-if [ -e /etc/init.d/populate-volatile.sh ] ; then
-    ${sysconfdir}/init.d/populate-volatile.sh update
-fi
+    if [ -e /etc/init.d/populate-volatile.sh ] ; then
+        ${sysconfdir}/init.d/populate-volatile.sh update
+    fi
     chown ${SSSD_UID}:${SSSD_GID} ${sysconfdir}/${BPN}/${BPN}.conf
 }
=20
@@ -131,12 +128,11 @@ INITSCRIPT_PARAMS =3D "start 02 5 3 2 . stop 20 0 1=
 6 ."
 SYSTEMD_SERVICE:${PN} =3D " \
     ${@bb.utils.contains('PACKAGECONFIG', 'autofs', 'sssd-autofs.service=
 sssd-autofs.socket', '', d)} \
     ${@bb.utils.contains('PACKAGECONFIG', 'curl', 'sssd-kcm.service sssd=
-kcm.socket', '', d)} \
-    ${@bb.utils.contains('PACKAGECONFIG', 'infopipe', 'sssd-ifp.service =
', '', d)} \
     ${@bb.utils.contains('PACKAGECONFIG', 'ssh', 'sssd-ssh.service sssd-=
ssh.socket', '', d)} \
     ${@bb.utils.contains('PACKAGECONFIG', 'sudo', 'sssd-sudo.service sss=
d-sudo.socket', '', d)} \
+    sssd-ifp.service \
     sssd-nss.service \
     sssd-nss.socket \
-    sssd-pam-priv.socket \
     sssd-pam.service \
     sssd-pam.socket \
     sssd.service \
--=20
2.34.1


