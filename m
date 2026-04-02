Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2ECC6B03
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 07:02:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10252.1775113335121690366
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 00:02:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=eLQiyWuA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8552aa7c38=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6325I3nt4029780;
	Thu, 2 Apr 2026 00:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=WSf0fvCiIxDLGAq/w8kCVqFvDXuI7z19a+8VkN98A98=; b=
	eLQiyWuAbG2PGX0DHWg4Lb16oc8pJinmuRVBZ9V+8SohIOKPh3XncCeTp/XGOY+F
	E+RTOGADCfoj9K7QE7Yf6prc7q8ipx9VberkiyMfnQKfT+kwh7/hoXvnFyPDocMQ
	gstfBHbG0i39/6YSAMl6sfCvALwl3FotmueUQJ8SClKEhEQ8w6EnEBOF0DfZNO9g
	ado3Hgcx/mrS/EatXbmtVutGMk8/c21s/poeylaEzLEQ0dcwx149yBTTIvafeltn
	x4NzyhhFgjpf4sHdXaJpQ32aTfE3/WvYDA5wGJJH4gMawZlbmVTTHZ2Pnk5JluG5
	XpwJKqtsPVfS87bafZ6ryQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6egby1nv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 00:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkdk+u2e4fBH1FwgkZTMH7/7W59M/+lM9AlhRrU5eTq4qlWzuhrdZoCmbJOgOWXcJPLVY0Qg+Tt+G5p5wmE+jhT8uZLn5NtzLe0Xm8AITzrEhc4d95Qz0H8V8tK6W1CnUkgX/JNAwfNssn6Wu6qLAsL1RjZ15SwZNNATTNipk3TpB+TeqKTa5HJjSAzs/1YaE59TBH3LJRf85UtNWL/zqxXisdVBsfoIhgSgOT0XIRNIgrc3HMcTqEqT1FzqqQAsZ73se4/P96NJvfU3vkH1/MeIPy57v/n1cbejrWEtZhdCQir+5P14ZN9RFYzZycoNS4+R+OnxDeyTunZBoCVyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSf0fvCiIxDLGAq/w8kCVqFvDXuI7z19a+8VkN98A98=;
 b=aC9BtgWFRz6KfmjhtYsK9K8SzcqLVu9Dn1jOU+acEWottr7aJC74GwS+px6oYNS3PfPTe3uNJp8pT1H3dm5JXiD1lk4YghLGZxi8M2XEtEUbtszh0O8VIFSc39nBp24PpAlOvd7jgTFX7HnxurFmctug2+qKoZtf7hsx37+MSF147Me31AdZQKjdapxsRvNoeyS0UQ8pkyAbCBxT0mS5EmFtQcX5nNyrwnwUL0ROR+59lNo8dMNTkxCjxbJ99GwWuy1NgWWok9QQY2gsbRUrM9wo1/DvoqLRQe2Z+HXVabmYxVfjvA3+mRGCtoUSU8c0kJWluVQXtxZ+oo2GOYU68g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5184.namprd11.prod.outlook.com (2603:10b6:a03:2d5::5)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Thu, 2 Apr
 2026 07:02:05 +0000
Received: from SJ0PR11MB5184.namprd11.prod.outlook.com
 ([fe80::7a3b:1182:1ac6:1afd]) by SJ0PR11MB5184.namprd11.prod.outlook.com
 ([fe80::7a3b:1182:1ac6:1afd%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 07:02:05 +0000
Message-ID: <083f7a89-ce4f-42e0-af5d-0471a4000387@windriver.com>
Date: Thu, 2 Apr 2026 15:01:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 Replace pkg_resources.Requirement
To: Scott Murray <scott.murray@konsulko.com>,
        yocto-patches@lists.yoctoproject.org
Cc: mingli.yu@eng.windriver.com, Yi Zhao <yi.zhao@windriver.com>
References: <20260331023812.3353409-1-mingli.yu@windriver.com>
 <fd46b294-d313-1a0a-2c61-0abc08b5bcbe@konsulko.com>
Content-Language: en-US
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: <fd46b294-d313-1a0a-2c61-0abc08b5bcbe@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::18) To SJ0PR11MB5184.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5184:EE_|SN7PR11MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c0758d-47a5-468d-78d3-08de9085bfb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	fJy1oAht7PUY7j1rlyqkdBSra6dIYphZgkRNFeWRqU8AT6XDszXSDvQmXKgJV1h3duqf0aluuiPE99kNsH11kRddlmO77OISRDTO6HT9h3B4qMwoScNQl1oK8fzj8KSRNH+g/RxkXVqobOJRsojbd+SgzeZONagmOdoATB+3N7z02WUoKtG39nsvJKx4lW0FD1BN4lQ6atJHyW5pDgcOxPn0B0TVgODcd0gUf6Xl8SrtfqNHbSz0vaBcn5LR1vPDsXvAe48BmJSrrNWLk7VeeYrZldtWjQMCT0pWJW2O0zIYOHTLcrcuBhP6bgofmhaxgi7Px7I99tco2kdfFKlX4d1MoQ3qyvS1EOAuMmDSd+jUcHFd6XqtLt25JCWzOsfccGjTru8h5p21ivSHL6g21QcF+Lvm2qFjkYdlR3MXQj0X0A7tdOXhCBjoc3bMYv2BzGhGaeCLGNG8Pi123a1Hr2aWiPp1zXCCiMcu1+5PgwIlWcvTXUOL9p9qr06nTVOvxYi1WHJG8YoEpuoVBR/nJ3yGtKQLCr3ww/KRfbZoTNdqnGlsFBLrxnZ9lbTCYcuYXlxjwju4LLnHqNr9Idc0c8Wjw3jDEzVM6lF0AfqTxBv3QmxMfzJw+seYsDxuJ2QHE3D0MAsoKaxzumISZ6YGGaqJGAQJqkFFAU0aagelL41hS0xK9Gnr+Q2DPik9oKnz
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXRKV1VmODA0TE9aMW1lVENmQXV6UitZcG40VWRQcXRDazdoMFFaNGxhRmkw?=
 =?utf-8?B?NW9wT0psOUVOK2VvYnBEWUYzTytLWVlIRndhdXA0NXR5UkI3UUZ6RHRCZ0ti?=
 =?utf-8?B?MGUrQW9MQjhHRWVXK21EcThxY25PV09rRFlyQkp0MUovMEt1Z1NCZGNxZ0Ez?=
 =?utf-8?B?NmZzMG5jSUZ5ZG8rYWptQVYzMVhiMXdjS1JMR0I0QlhuZmVlZHFCdzlMWmZq?=
 =?utf-8?B?NHplQ2hhaGttdnBYcmo2M2JhcHZkaDg4cXdJeG14c0ViNWtJSFcrQmdSOENo?=
 =?utf-8?B?MmwyU3NlOFpOYUJGQStHODJlZ3VqRHc4U1JGQU1TNUpCT2NyVjZBdld6ZHI2?=
 =?utf-8?B?RXhiQ0hpVTBGM3RTSmwvRXdiOStldjJHa3MveXRrcWhUek9UVjJybTZKMkts?=
 =?utf-8?B?M0IrdjlzZnpRT1ppa1FwTEw2Z0pEOEQvQjVaMjlaWEovSUMwUW4vbFlsQ3Jp?=
 =?utf-8?B?dGlQS3lNYisvb1NucHArY1pTVjJnaHJaSzNtcnJydXlNZm9rSkhFVnhwMTZ1?=
 =?utf-8?B?WFNaUkI3NHNnKzF2RXMyUWZOQWZrZUUrc1FFS205cUV3bHhNY2VlcU5wenEw?=
 =?utf-8?B?UTB3YWJ5eE1PcUw3ZDQzSUNVZ3VicFphM0k5Z0M4TmgvTmdtYjRvdE1XNGJm?=
 =?utf-8?B?TGpldjJCRFZUM0M3VjJhNk54VmhJR1RrY3JFMTQ4WktZWkJkZ0dodHpXYSs3?=
 =?utf-8?B?MFRhN3pBVVp1OFdxY0tQRVN0WmRjUEpaZDdrWU1HZGpkUGhyanZoQk42WEJ5?=
 =?utf-8?B?a29yMkVDbkYyb2FxOGhFSGRSbDhrbU5TT1BLTXJXaFpWdytvby9xOC9SUVVB?=
 =?utf-8?B?ZWdJbE9lNCtwdVlXTmdPanJCaDFFemUxVHUweWdaSmlza0w2QzZpdGJJMDhD?=
 =?utf-8?B?VGJoWWZmc0ViYVFNejNGU2pUNDRzUS9ldnc4TStrYjRJZEFTeEFjQlhrZkJm?=
 =?utf-8?B?RHZEMFFWQktzMFJoTnUydkRoeHFDcnVpNHNMN2xTT1lKaXMxK0ZqeTNRNHJ3?=
 =?utf-8?B?RjRmWTRvbkNtV1dXQy96OVoxVmNEcG5WYnhnRkY1dEZZSHRscXVSaG5xQldE?=
 =?utf-8?B?aUxpMWg3NXZrY3pUSU5idEkwd0lYaHdTZkdFaG5meHMveUY5a00xeHUwekFx?=
 =?utf-8?B?bnB6ZUZTUkExTEsvVW9mZkg0WnRUQnNaNnZka1huMWk5QVN1bEZQK0NHNjVn?=
 =?utf-8?B?bVBWNnRuYmV6YXp1TVoyZjU5VmIrNVdGcGM3MCtZT2N1L0ExZVJhZUFyeU1E?=
 =?utf-8?B?VVpiVWxORXJPRnpDd0twSHlXMHdzU0VnV0NrOTltZ1BreURLcFhTTUpxVEZu?=
 =?utf-8?B?Nnk2Z3hCS09BK0FrNjd4aGJTNjIrMXhoc2Q3SjNYVWpqWlI2YzZvN2ZxRnUv?=
 =?utf-8?B?d3hiL2lmbEhkTkx4Z1lDYitrQk1DMGYvWm9JckJzdnBZNnJJUHVqbWtYdHlG?=
 =?utf-8?B?TE02ZHlMRnJKVER5Z3ErYVVDZEVLYU5vbk1jSk9pdm1pUzVpNUpibHdlZmZG?=
 =?utf-8?B?T3gvS1hCM1ZVWHd6QVdmUHQ3WjJqRkZhUjVRZHF4TTc4eVJHODJhd1NTd0dX?=
 =?utf-8?B?R0VVaHdESEtkL09KNkl1R1dpK3ErN2NrUU4xZHNLaGNoRkZyTHdDZk1Tc1Ba?=
 =?utf-8?B?Z0ZESTFjMzZxUXRNUGRvWkk1K3p3L2lwUW1VekFBdURDUlQwOWxYOTJvUGJV?=
 =?utf-8?B?cFROeHp4bTNoa29JNTRuOTRuVlQ5RXlweFZjL1NRbnNnNE54ZGpkZXFqa1ZN?=
 =?utf-8?B?ZHptRlR2S3BmSVJPZ25RaFpuUVprZUpJaEtpWG5ueTgwbXZuR0VaeWxzajlO?=
 =?utf-8?B?R3RFUlN5TDBVOGNVenFZQ1VjWmVVMldLSDFDYXkyZXZHYnFjM1FWR3RkbzIw?=
 =?utf-8?B?V1ROa2VlcGZwOEJEZWhBcHpySCs5ZXR1U3RhM2dMUXlPZUxNcnkyeFZvVkVS?=
 =?utf-8?B?OXE2OGFYRzl2NGJ4ZW9VY0c2czE4dllIRkpuQlBxbmh3anJBdkF1S0ROYU9p?=
 =?utf-8?B?elZKMXJjcGk3TDYzMUwrcS9QV2pvRG1COUtSdm9ZdkQvZGltbzVlWk9vN0wx?=
 =?utf-8?B?M25QZFdOZGtJcnN2b0Y5L3hQSVh1dUlIT3JYbkp1V3c3OUJyOTc1NTgvWWNC?=
 =?utf-8?B?MEExZ3JGUk50c2Q4QXVkYUpCdGw4eml0VmNkcTlJT1dyQmROS01vbG0zWlRn?=
 =?utf-8?B?QUdOMzhNSCtWQVVUZmNmQk9iNXBCYjQwZG9lUnZWc1BnMmZYa216dEd3UDRR?=
 =?utf-8?B?UTMrQmxua0xPdHVWbW91akJUSk5QUHF0T0hUMTZlOWFSejVZUXZFVFR4OE1m?=
 =?utf-8?B?MkZGUU1meXVSd0RteVlLUm1YOEVoUHh6UDVISVczYlpJN0VXZ2V4UT09?=
X-Exchange-RoutingPolicyChecked: 
	KaSmMBe7NSc21q+6D/bxg1mcsdmuJC/whD/8ho6CZtuSjrCSv8xk2+V5qBExgeh9Etkcq06nKMAkZhbYsa8DMEmmRvtpY5xtxznfWMhAeFFpDzKLonGRs0bu+rhG5EpeP3Y5+cT8EbdAtqroy2lMdKVhObBPcsr8d9u1LygKY2mmwGoPzRMsGDTaJEo9qZes6LxaFbBzi3fqGunXXoP2llrD+YeRhjFTtvZqtH9F8I01E7rJzOT8k9UqQjfUlasCcfmExepBuqQu5+k10cjDVl0gCjyePVrm4uSCWlhao1WuAVHjRQCqG5rkukga9OVuD9fC7vDliPG67u5774GF8Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c0758d-47a5-468d-78d3-08de9085bfb4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:02:05.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlHhWGx2ddRcvjHrTMVflZaqYcySRRQNgTHZQQVQjHkC2ljV1BSzV1wHja4brCbWYiu/JyJl7+jNFjcGzBO2dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2MSBTYWx0ZWRfX6qrsZwItfUKq
 QqY9HpOkd91qB+hzHyasTly+ku7uyB5jNGOwoIWd1vt869rg/fIvbZQCiGVMXAFPEfwMiJrCdmE
 OAfi9+vUWWXJPjWdL6C/yWjFqa2lqhsMUW41uBxmd2c0MuR1ptmTSQa5wR03tOvlsm6oGBvjq8O
 5POnrEuxdfEwWRbfbptSlNpBfgNaczD+5vVBcUNlyHVlbT76TyDhUEu7RmKuMuD5/VnGFfcxa90
 IJ9J65eApXycOBSDdc+SUv6k7IoShyEQRntzB0A58fGWV68UpoEuhJwQzDO7lIsYrhArc4jFjOg
 czjy6i/BPpIZM4ZT9kfk3ZEPbiGAehO7kkkzbs0BR18GOLnwIoJYrIESLNdsdpoV3Uc0q9du/4O
 BjNQECkwMMbEUFsvB/VBMP/IMrdAgAVxVWwFsptaXB78HqyJklczhtMuMdFG/3+hU4KXuzRCPhs
 QffbDW3RXyQAFxt3Y8Q==
X-Proofpoint-ORIG-GUID: XW10KB751tiXGrQQYpxDVJus2vghXGFl
X-Proofpoint-GUID: XW10KB751tiXGrQQYpxDVJus2vghXGFl
X-Authority-Analysis: v=2.4 cv=fvrRpV4f c=1 sm=1 tr=0 ts=69ce1470 cx=c_pps
 a=jMLRuqkCa9WS4sFRI2wrKA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8
 a=LNok9MEPo7IE5OsyJc8A:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020061
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 07:02:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3607



On 4/2/26 04:59, Scott Murray wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Tue, 31 Mar 2026, Yu, Mingli via lists.yoctoproject.org wrote:
> 
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> Backport a patch [1] to fix below build error.
>>   | ModuleNotFoundError: No module named 'pkg_resources'
>>
>> [1] https://github.com/ComplianceAsCode/content/commit/12f2503
> 
> It would make more sense to upgrade to v0.1.80 which includes this fix.
> If you don't get to it in the next couple of days, I'll try to get it
> done in the next week (I've some personal travel, so no guarantees).

Thanks for the update!

The upgrade patch is as
https://patchwork.yoctoproject.org/project/yocto/patch/20260326151234.2077655-2-yi.zhao@windriver.com/

Thanks,

> 
> Scott
> 
> 
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   ...01-Replace-pkg_resources.Requirement.patch | 127 ++++++++++++++++++
>>   .../scap-security-guide_0.1.78.bb             |   1 +
>>   2 files changed, 128 insertions(+)
>>   create mode 100644 recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
>>
>> diff --git a/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
>> new file mode 100644
>> index 0000000..604e099
>> --- /dev/null
>> +++ b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
>> @@ -0,0 +1,127 @@
>> +From 12f2503c51484005f29dad75c80395352ac8b668 Mon Sep 17 00:00:00 2001
>> +From: Matthew Burket <mburket@redhat.com>
>> +Date: Tue, 18 Nov 2025 18:32:45 -0600
>> +Subject: [PATCH] Replace pkg_resources.Requirement
>> +
>> +Replaced pkg_resources with a custom RequirementParser.
>> +It implements just enough of pkg_resources.Requirement to work for our
>> +project.
>> +
>> +Fixes: #13902
>> +
>> +Upstream-Status: Backport [https://github.com/ComplianceAsCode/content/commit/12f2503]
>> +
>> +Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> +---
>> + ssg/requirement_specs.py                      | 51 ++++++++++++++-----
>> + .../unit/ssg-module/test_requirement_specs.py | 11 ++++
>> + 2 files changed, 49 insertions(+), 13 deletions(-)
>> +
>> +diff --git a/ssg/requirement_specs.py b/ssg/requirement_specs.py
>> +index 10e6a6f35d..16637ddff8 100644
>> +--- a/ssg/requirement_specs.py
>> ++++ b/ssg/requirement_specs.py
>> +@@ -1,18 +1,43 @@
>> + """
>> + Common functions for processing Requirements Specs in SSG
>> + """
>> +-
>> +-import pkg_resources
>> + import re
>> ++from typing import Tuple, List
>> +
>> + from ssg import utils
>> +
>> +-# Monkey-patch pkg_resources.safe_name function to keep underscores intact
>> +-# Setuptools recognize the issue: https://github.com/pypa/setuptools/issues/2522
>> +-pkg_resources.safe_name = lambda name: re.sub('[^A-Za-z0-9_.]+', '-', name)
>> +-# Monkey-patch pkg_resources.safe_extras function to keep dashes intact
>> +-# Setuptools recognize the issue: https://github.com/pypa/setuptools/pull/732
>> +-pkg_resources.safe_extra = lambda extra: re.sub('[^A-Za-z0-9.-]+', '_', extra).lower()
>> ++
>> ++class RequirementParser:
>> ++    name: str
>> ++    operation: str
>> ++    version: str
>> ++    extra: str
>> ++
>> ++    def __init__(self, target_v):
>> ++        match = re.match(r'^(?P<name>[a-zA-Z0-9\-_.]+)\[?(?P<extra>[a-zA-Z0-9\-_]+)?]?\s*(?P<operation>[><!~=]*)?\s*(?P<version>.*)?$',
>> ++                         target_v)
>> ++        if match:
>> ++            self.name = match.groupdict().get('name', '')
>> ++            self.operation = match.groupdict().get('operation', '')
>> ++            self.version = match.groupdict().get('version', '')
>> ++            self.extra = match.groupdict().get('extra', '')
>> ++
>> ++    @property
>> ++    def specs(self) -> List[Tuple[str, str]]:
>> ++        if self.operation and self.version:
>> ++            return [(self.operation, self.version)]
>> ++        else:
>> ++            return []
>> ++
>> ++    @property
>> ++    def project_name(self) -> str:
>> ++        return self.name
>> ++
>> ++    @property
>> ++    def extras(self) -> List[str]:
>> ++        if self.extra:
>> ++            return [self.extra.lower()]
>> ++        return []
>> +
>> +
>> + def _parse_version_into_evr(version):
>> +@@ -62,11 +87,11 @@ class Requirement:
>> +     A class to represent a package requirement with version specifications.
>> +
>> +     Attributes:
>> +-        _req (pkg_resources.Requirement): The parsed requirement object.
>> ++        _req (RequirementParser): The parsed requirement object.
>> +         _specs (utils.VersionSpecifierSet): The set of version specifiers for the requirement.
>> +     """
>> +-    def __init__(self, obj):
>> +-        self._req = pkg_resources.Requirement.parse(obj)
>> ++    def __init__(self, obj: str):
>> ++        self._req = RequirementParser(obj)
>> +         self._specs = utils.VersionSpecifierSet(
>> +             [_spec_to_version_specifier(spec) for spec in self._req.specs]
>> +         )
>> +@@ -131,7 +156,7 @@ class Requirement:
>> +             bool: True if the package requirement is parametrized (includes extras),
>> +                   False otherwise.
>> +         """
>> +-        return bool(pkg_resources.Requirement.parse(name).extras)
>> ++        return bool(RequirementParser(name).extras)
>> +
>> +     @staticmethod
>> +     def get_base_for_parametrized(name):
>> +@@ -144,4 +169,4 @@ class Requirement:
>> +         Returns:
>> +             str: The base project name of the package.
>> +         """
>> +-        return pkg_resources.Requirement.parse(name).project_name
>> ++        return RequirementParser(name).project_name
>> +diff --git a/tests/unit/ssg-module/test_requirement_specs.py b/tests/unit/ssg-module/test_requirement_specs.py
>> +index 13c3292b5f..ae078e9a8f 100644
>> +--- a/tests/unit/ssg-module/test_requirement_specs.py
>> ++++ b/tests/unit/ssg-module/test_requirement_specs.py
>> +@@ -33,3 +33,14 @@ def test_parse_version_into_evr():
>> +         v = requirement_specs._parse_version_into_evr(':')
>> +     with pytest.raises(ValueError):
>> +         v = requirement_specs._parse_version_into_evr('-')
>> ++
>> ++def test_requirement_parse():
>> ++    req = requirement_specs.RequirementParser("package[NetworkManager]>=8.7")
>> ++    assert req.project_name == 'package'
>> ++    assert req.operation == '>='
>> ++    assert req.version == '8.7'
>> ++    assert req.extras == ['networkmanager']
>> ++    assert req.specs == [('>=', '8.7')]
>> ++
>> ++    req = requirement_specs.RequirementParser('linux_os')
>> ++    assert req.project_name == 'linux_os'
>> +--
>> +2.34.1
>> +
>> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
>> index 919a09c..e42b054 100644
>> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
>> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
>> @@ -8,6 +8,7 @@ LICENSE = "BSD-3-Clause"
>>
>>   SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
>>   SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
>> +           file://0001-Replace-pkg_resources.Requirement.patch \
>>              file://run_eval.sh \
>>              "
>>
>>


