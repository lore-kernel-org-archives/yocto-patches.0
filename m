Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA4CEF36FA
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:43:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9028.1773042184129793246
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 00:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sOZBQxFq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75285c4c5c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6296sM9d021137
	for <yocto-patches@lists.yoctoproject.org>; Mon, 9 Mar 2026 07:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=7EUTTXzlCyyVenfzLPWwpmCBpX+TmF7PYnIGgmLCCEA=; b=sOZBQxFqXwAZ
	m63Zqcpm+bTKSWPzJxeVqFJXPpFC2YQyCMJlrqSmbglU/BleGtau233GzYNYUhSq
	1iDDR4ZtvJkwvTgKVMv+UVCqtUKa2HoweoW85SMVtV3MI+MgMKStdmuTanv69NBp
	SrgVPlADR/LVyYTE7ySzCzddCoxwY0RTF/vprvPYi7AIpz5m2qIgsDM7NrnFDeJ+
	GdoNHLJtBzlD6PU9lBe+rmGO5aq4O4on/qeRi50MjEFK4ORSm7Q0b2gR26i6LWe4
	GUB+pd2AlrGFFkBVhwoWULabaBnQPyKvZT04Zu2QS1skTy3msdKnwOCnMBqCPrA0
	OPJcypP3wg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb081jd4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 07:43:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX+SqEaJbpZYYS5EE1sJXMxlrgQsHZ/sNir0kv3fuiv60vKQcdhkOCpgpgiwL1ay+4rZXvpGhU+/+xgVqDFwA11PttGFhZ9mQybAn/HJQXjXiFOyQl//okFmq2453xLrhBI5f9taCEmJkY4zj1tZL50RUyLN0tgjvJwNnZpVAXIBh56H4c1vo33ae2in0hLQ8plMuNbRGS/ZlpnSaMxlWrOg/UXIL3rC03/9byGCBP5/u9UT4/QhdfikanL6O9x3roigFUyi24rP8hMl2GfrWNyAsxxyBtnBFNzgs9XwFCd/Iyfha5ejPxSZnewHTQIArr5APDkHJhKRlupMPy1FlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EUTTXzlCyyVenfzLPWwpmCBpX+TmF7PYnIGgmLCCEA=;
 b=BhN00fHWjJHpYqHpH/PdtKVhKhJCmgM+oS4Ml7y5Sh8u04TfEjoCsu2sAxsgsR5jGYWbdpcr2N+KBFrMW6DR8BhTWHQtz1L9rQxAC7jiK1s9AdoAplh5WHkSlSwFbbkPmWhfsPKCRz0LKbA2JTfMtoA0dScXX1mAfug6cXYOO6bn84ZfeYdvyzYvFKuEPh7I5/kxqlKiNCw+L2cD1PI4J7esG3pd6KbR0EZsPL3P7MycZB4C5B/x9YlhMQVo6PsTWkRIYaCB0sWShQcTfXXgPh4N+w06juZ32bi7cVEvurCmXQxGjcrB+V9teb/r2Y8kLwFV/arYRqNsUT0RWDly8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 07:43:01 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 07:43:00 +0000
Message-ID: <66cd0701-902b-4bdd-840a-6769cadd009c@windriver.com>
Date: Mon, 9 Mar 2026 15:42:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Introduce a new SELinux
 domain for the Qualcomm tee_supplicant to ensure proper labeling, isolation
 and access control under the target refpolicy.
To: yocto-patches@lists.yoctoproject.org
References: <20260306061903.2080456-1-wenjia.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260306061903.2080456-1-wenjia.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0043.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::13) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 157de292-7746-4ebd-c302-08de7daf7cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	p0N9bfSaWyGyDM22ySTknqLFN6LdrUrirB4gQTFehEoH0iUKQPQPTnfZhyiCwr11MBSh/2ZSYlc9Eb30rPV+hx6AstqG0o/YEvd1BwjCc2iQUMqvPkjcFQggXYD5CysOsIYZ7TK9JJtsuQ4wCEicDm95msxF8OU+fUj+2m/QWHC1bcWp0v7ulwrSESO+zQEkbT5oqu0CSxi4VMUSSH5cXtw9p8p64IRdriuMiCrqhlchdikFHCJWHrHiJbLyS5RFJOOzlsgN2TJ0g5R86AS/XVLGdIclCw6hZ0X0czKq067mAPQOBTXw2xdr3HeLIZGWY3cxiyNIjiJEKko0GqmrMp8SMa9yEYkzdOrlaKs+i9gdASdn9IP2H8SP87ySnS62abaRP33yLHnm/K5QbL7bazTL5xDfxWhDdpugQpPYdqqYsfY3KlOcUr161/gexHw4FBPLBLVK+4Lrrqdb7pzFgYNqvHRcXoq5FCxQIt8yNoGu8W5dBxhh+ppPW42sxfRDsLM9o9nun2b0v1MFPrDB6mrWmrD1BbCw1aj1JDKwyEDXa8ST/XhLjH2xEVh3qw0rASia06uqu+maEnB2K2YcWDhXpVE8Rs7/TRzGQXYasNS5TDENh0c6PQz5QBYtcmMeibKkcBFU2dzG22viCP+lVwP84yd3n8P+QmZFMG7l+eCHKfXVMEDbZ+xDL3zTCvTI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NTdhTXZkdnJFRDhQSXZlVmRLcEJ1L0lWTy94REhpUE9la2grU2lNNXduS3Vs?=
 =?utf-8?B?SHVXcGFHTEw3VDJpMk1icHNCMnRsMWVDWUc2NnE5VDhFU2xRUm84VE9QQWIy?=
 =?utf-8?B?cVFYeTFRSkRpekliS0hJdkEzcHhmcktFaE1PeTlGZW5Hc2NrMXo5Tlc3cFF3?=
 =?utf-8?B?YVdES1lOSVBZWi8zNzJhTHJHdFVhbGhwOFRjVFhSMDRkdGt2Y2NvY0VYcEww?=
 =?utf-8?B?eW1yMmhmR0lCNThwRTBPUDRxWXFJZW1CaENaK0hLM0xkdHFTcC9wbURNb0Q5?=
 =?utf-8?B?T0xTZ0VkOHhMdUtkaVZYNUkzUEVuKzFKSzhSQm5aeWZ4TUZvY0N3VTVhTkZi?=
 =?utf-8?B?MmtjcmlMSGwxdnVlRXkvTERUSS9DU2JVQmtHTmFFdWRpbHU2cDhpRHBvckpO?=
 =?utf-8?B?Q29UWllrSGFuRGVTc1Yra2J3TFFNUFRDcjVtSi9LMUdIc25sU1k0c3VZQTFj?=
 =?utf-8?B?SUJDUzA5My9iRm9CL3M4L3g4MzRXTzVhWWRDSW84M29IRHVzUzVSb29NTmNm?=
 =?utf-8?B?V0JZV2p6STFzODFUeFB1VjZmSVNZblV5Ymt0aXJKUEdHdHE3emUrQVYrMUJj?=
 =?utf-8?B?N2pQeXlsL1cxWU1oanV3TFNMUS93WU1aTzRMQWRRNkpLazZSOEpXNUtTVHBJ?=
 =?utf-8?B?TUt1azJsTjBROTRkQVpOelNFdGMzT0ZnYXovbVh1NHVaU1hHSTdibitxMHUx?=
 =?utf-8?B?cVJXSExxZVY1NThYZWozVVp0NndIWStMeEdXYUxFaW1hTVM0bUNNcC84aGw2?=
 =?utf-8?B?eEJRNDdiaE1wMWZLaGRhRG1oNkFSRUdSV0IvR3g0QVNvLzcyS0doblBiRmw3?=
 =?utf-8?B?UGxMeGl0bUpEWTY4ZzVFRUh4MGxuOVMybGlZWGZGaVhwV09pdVlQc2tob285?=
 =?utf-8?B?RW1kNStkOTFqRlk3L1Q2MW84bEJZVTNNcTRxNlg0Y3pudi84ZEErZXFIdHRz?=
 =?utf-8?B?MGJPSVZmazN2aG4zQmV0dEhzUEZZNUZkS1pjbmhTWVllZGgvbVY5SXMyWVFY?=
 =?utf-8?B?L05ST2lFY1hZNnJCMXJRMDlSM25GaHhRRTkweFNXT0Z6VFVWdXFNd0RTU2Ir?=
 =?utf-8?B?QVpoQkNXQjBCRFJ6d3dXN3pUdkpDN0VJWk5rZ3piUlpES1lGYTloQ2x5anBT?=
 =?utf-8?B?cGZ4V2tJcmJ3WDFNZ3lTeTF2S3N1NGJVaUV0NzRYMElHTWlKbUpmbk5ZS0hk?=
 =?utf-8?B?NjZxbnR4YzhmVHdHaHhmSUdsODQ1Y2UxVWJwM1c5dVFGa01JT1BFSXUwNXVH?=
 =?utf-8?B?ZzVubE84SG1DRzhzR2lxUUFERGtsWkVNWjZtNWpsMHhBcGVUT2lOYlBhYlkv?=
 =?utf-8?B?dnVXWmw1bVhmcWR3RWc2czRPbXVWS2xvRHVqNzR5M3ZnMkRzanRZcFhadmZQ?=
 =?utf-8?B?TW9yV1hubkJ0V1pWRU93NE1BRk9oSFVWenBHcDhwRDdDd0pNeDRVRUN0V2F0?=
 =?utf-8?B?TkZzekM5ckEvcVk1cUlmM1g2NWxtb2NaSUVoczU3b2hQRUNWRzN3UVJtc3dl?=
 =?utf-8?B?aDFYZ0VpZGljTmF2QjFQamxkWGhsZHdNaGppeGpvenhvNGJvQ2Z6WlNsN0pR?=
 =?utf-8?B?b3JnWVE5REk4aXRDYW02MkV2N1BITi9PbFJoN3AzcEUvcHpyTmF6ZmZLa21i?=
 =?utf-8?B?UTg0c3RXdDBEUWRhZm9wWm9EN3M5Qzl5WWNFa0kwS3RpeGNZZzdqVzRON0Fu?=
 =?utf-8?B?L0pNTWgvUGZhSWpNK09hMS80b2x5Rk5OckVvTlIxVUJ2V2xHSTAzNTRhWHFs?=
 =?utf-8?B?NWtTQVZHUHFvbEx4QmNmOVdzS1pNSGIzUktwN0hyZjA3UlJWbFErZjliNFp5?=
 =?utf-8?B?VlVPV0tjT2U4WVo2enEzeW5iNmJaSmhvTnk0RmdBc2JqcXEzU0VvdW5KQWVz?=
 =?utf-8?B?SGV4b3V6dTBsTjUyRWp2SE1mcXdtOVAzZVh5Wmx2bUwyYytSSkIvcnovS01y?=
 =?utf-8?B?NkpRemdkVmxlbG1kMFprWUNYcjZpZUR2SlJqZWwzNE5vRmxGYTVGNU1pSzVx?=
 =?utf-8?B?NnREbDJLN3ZUU0U3YTdZSnZUSzZiNTlqNUJzRkVkZE9UY05KbGxDeE5SaTll?=
 =?utf-8?B?YUJCNU5ucGZscXUrTlROcnhFcUtLZ21VRHozSGpnekh5Nm1YRG5iOG41UEtR?=
 =?utf-8?B?dTkzTzNyR2tnODE2Y1dteGtJdFpLZm5BczdZb08yb3FneHhwNWVDWTJzZ0Z4?=
 =?utf-8?B?UGgxYklHQ3ppWlBMc2lHaW94S0QreGxzZmk1ellqYk5hUGtrS3ZZT0hpemZs?=
 =?utf-8?B?TVVrRFdodWxqMDQySDFFZ29nWk5zQU5Dank5Tzl2eXk1cytxZTdkbHJnTEY0?=
 =?utf-8?B?RVZSMFZVTFg3RmkxNDM1aFdtazU1cyt1RGprSUV2cWJQN25LajlMZz09?=
X-Exchange-RoutingPolicyChecked: 
	wJcXXuh4KxeZpxY2EU7PwLBL2GncjmklHEMP42zHw6wKJRRWRdK6HGUO6d6tFSZpSBzgwkWkxGezeB61+fEHw6l5kXGP6Ih1tY6KFyQiPhAFIWba1ziDb7fozGQBSEUkDhiiNap/EO/fUF+fG6MoAQ+Ce1tLtX7NzUxsnsVC8Oq9LPcYSjEIHqKSBs/HDqNDPCQFAWdGhZnG6SHWZQyWthkVuVoVNZUNMWd8677U7BzjZ4pqolODIy+qw4cqE+gZctGF/9IrhpgX7hQKqNq9wmJ8UP9H5trYOnYU6c2V/D129gCj7hUHwOxbbKglHrHgeZbAwtYhJaagrsPgjQvfvQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157de292-7746-4ebd-c302-08de7daf7cf4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 07:43:00.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPiVu5XrERVKDO8YbMKUCKfww442JbcGC1sUt9HGN3p6TIcddbXmu+hRStk8TE4S5ssuyhjqHqZa1IThHIwrmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-Proofpoint-GUID: TUOmGL26kDY1BkiEL1y5mvsgT5ou9-x2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3MCBTYWx0ZWRfX2Dc4jQavIVSq
 J4b5POU1rYXtYXIurGqL1skGwjVGVdZzJrs9KbD8war0yLCImK7SblKlkuAo0rUMyO5o9fejBQN
 kzqoXrUw9cPEyAgocFYsXBj0PY6PMC626jYz3PCJGDPMpPeBk0nuOWKv9m+HVHEHTYzSPZq9+dS
 hI8hMSC5hn8Aa6FJVGUtjBAk5yj86SHgOExsXFmNgm8unbBlO7NaiLOGTOo3XyS2ytN6lbMcIKO
 Y8G4rWdbiKKWORcFfIFDhLp5mZtFDlUlGuioDsckE3hJEswGq5hz+Rc0ESOFrYHggBcWto5i2ZH
 IBHdn8RJQ3wvRkbQnOXkO/5JqZ58rVAE2G10XuJ+2C+PXXnFzhA2eaw5CmW3EOQjVE7p9i3NmsC
 MP9GpXh5jWpSH/ACAi4mabn4iwt1MvT0Fu80ns45SkK39qytH2F+sXSWBbIMJ9QowWYSJ7XfO4Y
 sgjU0rHue4X1/S5Ul+A==
X-Proofpoint-ORIG-GUID: TUOmGL26kDY1BkiEL1y5mvsgT5ou9-x2
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69ae7a06 cx=c_pps
 a=Vharl4M+XVTaKge5CdhMZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=uZKo6Mtd0XcEDfeS:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=IUqmpZrl9aRuRRHrBUEA:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090070
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 07:43:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3379


On 3/6/26 14:19, Wenjia Zhang via lists.yoctoproject.org wrote:
> Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
> ---
>   ...ntroduce-SELinux-domain-for-tee_supp.patch | 105 ++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |   1 +
>   2 files changed, 106 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch
> new file mode 100644
> index 0000000..f921e16
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch
> @@ -0,0 +1,105 @@
> +From b2f7220034bd340574d14222e88cb762f56bafa5 Mon Sep 17 00:00:00 2001
> +From: Wenjia Zhang <wenjz@qti.qualcomm.com>
> +Date: Thu, 5 Feb 2026 13:48:10 +0800
> +Subject: [PATCH] tee_supplicant: Introduce SELinux domain for tee_supplicant
> +
> +Define a dedicated domain (`tee_supplicant_t`)
> +to confine tee_supplicant service, ensuring it operates in
> +a restricted environment isolated from other init processes.
> +
> +Define a inferface of /dev/tee[0-9].
> +
> +Grant the read and write permission to tee_supplicant for resolving
> +AVC denials in enforcing mode.
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1082]


I see these are backported patches. I plan to update refpolicy to the 
latest rev in a few weeks, so these patches will not be merged at this time.

Thanks,

Yi

> +
> +Signed-off-by: wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
> +---
> + policy/modules/kernel/devices.if          | 18 ++++++++++++++++++
> + policy/modules/services/tee_supplicant.fc |  1 +
> + policy/modules/services/tee_supplicant.if | 10 ++++++++++
> + policy/modules/services/tee_supplicant.te | 17 +++++++++++++++++
> + 4 files changed, 46 insertions(+)
> + create mode 100644 policy/modules/services/tee_supplicant.fc
> + create mode 100644 policy/modules/services/tee_supplicant.if
> + create mode 100644 policy/modules/services/tee_supplicant.te
> +
> +diff --git a/policy/modules/kernel/devices.if b/policy/modules/kernel/devices.if
> +index dd8072f37..bbdb45b98 100644
> +--- a/policy/modules/kernel/devices.if
> ++++ b/policy/modules/kernel/devices.if
> +@@ -5032,6 +5032,24 @@ interface(`dev_setattr_all_sysfs',`
> +     allow $1 sysfs_types:lnk_file { read_lnk_file_perms setattr };
> + ')
> +
> ++##########################################
> ++## <summary>
> ++##	Read and write the tee device.
> ++## </summary>
> ++## <param name="domain">
> ++##      <summary>
> ++##      Domain allowed access.
> ++##      </summary>
> ++## </param>
> ++#
> ++interface(`dev_rw_tee',`
> ++	gen_require(`
> ++		type device_t, tee_device_t;
> ++	')
> ++
> ++	rw_chr_files_pattern($1, device_t, tee_device_t)
> ++')
> ++
> + ########################################
> + ## <summary>
> + ##	Read and write the TPM device.
> +diff --git a/policy/modules/services/tee_supplicant.fc b/policy/modules/services/tee_supplicant.fc
> +new file mode 100644
> +index 000000000..9c6e77836
> +--- /dev/null
> ++++ b/policy/modules/services/tee_supplicant.fc
> +@@ -0,0 +1 @@
> ++/usr/bin/qtee_supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
> +diff --git a/policy/modules/services/tee_supplicant.if b/policy/modules/services/tee_supplicant.if
> +new file mode 100644
> +index 000000000..e22a531f5
> +--- /dev/null
> ++++ b/policy/modules/services/tee_supplicant.if
> +@@ -0,0 +1,10 @@
> ++## <summary>tee_supplicant</summary>
> ++#
> ++## <desc>
> ++## qtee_supplicant is a userspace supplicant daemon that
> ++## services callback requests from QTEE via the Linux TEE subsystem.
> ++## It communicates with QTEE through /dev/tee0 and provides normal-world
> ++## services required by trusted applications running in QTEE.
> ++##
> ++## https://github.com/qualcomm/minkipc/tree/main/qtee_supplicant
> ++## </desc>
> +diff --git a/policy/modules/services/tee_supplicant.te b/policy/modules/services/tee_supplicant.te
> +new file mode 100644
> +index 000000000..2d5905318
> +--- /dev/null
> ++++ b/policy/modules/services/tee_supplicant.te
> +@@ -0,0 +1,17 @@
> ++policy_module(tee_supplicant)
> ++
> ++########################################
> ++#
> ++# Declarations
> ++#
> ++
> ++type tee_supplicant_t;
> ++type tee_supplicant_exec_t;
> ++init_daemon_domain(tee_supplicant_t, tee_supplicant_exec_t)
> ++
> ++########################################
> ++#
> ++# Local policy
> ++#
> ++
> ++dev_rw_tee(tee_supplicant_t)
> +--
> +2.43.0
> +
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 2e1a929..e3d38ee 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -74,6 +74,7 @@ SRC_URI += " \
>           file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +		file://0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch \
>           "
>   
>   S = "${UNPACKDIR}/refpolicy"

