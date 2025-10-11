Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E43CCD18E
	for <webhook@archiver.kernel.org>; Sat, 11 Oct 2025 09:54:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.8111.1760176455753890109
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Oct 2025 02:54:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=eAKRRUi3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=23790b5689=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59B8Fv221144673;
	Sat, 11 Oct 2025 09:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=yqsfZ954gQVhcVAqACcO450OpLGOo5NJbdBT/AZ+o+8=; b=
	eAKRRUi3PCY6YMyzBm27ORY1/mK7HrW2vC7gsHHs0prIBe9dvvOIhL7cEBF59kUG
	rZwEU5LURqvc5Mr4DtBaiD/xP6hAzubXAIgz7zYWwi6PDV6p25Lzxg5NJdqTiEPA
	9rHn52w7Sfnjx5DyeH9X4d+/Xjg0eESn8sa/sFoCjv1dJ98fE8bSf6/n8FYi60Mh
	GUXKEd5Rf8UY1msL1DxecfVrttf2SOcKLjqJqM6lJw3Tws31c/ps76qkZ6/C+4rH
	m9DZmLLlrCi3TJ1BG56/HjjkBqHK3qeMQooMg8T0MpKM+y6UmxXTtcOEnP21zn2z
	APpIMhtNWKbgRV91/S5ZgA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qcewg9qp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 11 Oct 2025 09:54:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWvnlAZIb+JWAulhuPxIDjnB/QTR2ET9uJSlf5q748LL3xsPQVNFx+7EgC/ui0jrqoy7R3LMnp7QqTqek9qcZJiFkXKij/SE3bto9No5dQ3GaASmWLjLlyOtOuVeeCmBC53nlIqm9JSbuuFi0W7cc2pjstLAMHpINMyxQKzX4GGWphrcuX8CnFr/d8f8fQNYlzrdPuuudCeM3zyxeuAt5tuDuXNI8g7ZtL0f7JxzSvs3vlD+qE1oRLGditWAUCBeiuhvR537NbLREFvaTTz3SJTZBvje5MIir0F41XRaVuv5szrrdtGbFLSwhTzfWU7Jk7QmMFG5ounvLTQnlx9JgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqsfZ954gQVhcVAqACcO450OpLGOo5NJbdBT/AZ+o+8=;
 b=lq+PB+eRMTfULQL9bH6HYT86bRNd0u7XnVqE78uLQECuvFdWK1jLc1KfM47vmGteHygBaSEsp4ULeHuLsoIwWx1r/0EgNhgeciAuHKAB1a+/bIuLzt1vRKzERkmsCGqRFIncP5lx31gIFt6cA8mxW1VG90Lx2TNB0r3YZISlstKOHznJRPtFcBkSSRbQ99wd8AQs0FmQUgKT+sW++rCfcedC5BiInUgYlTJA+Qk5x6DKkQwypJizhp42Ce0YJdRexmUnxbGcz9YoPr5Epc/6Ct4mU9X9hBxhVEIpjQX1tuGXKz6Zku+NNLyQ5WyGiqpO3zzpi/osX8abOafJxq/ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:54:12 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:54:12 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH 3/3] libgssglue: update HOMEPAGE
Date: Sat, 11 Oct 2025 17:53:53 +0800
Message-Id: <20251011095353.2909174-3-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251011095353.2909174-1-yi.zhao@windriver.com>
References: <20251011095353.2909174-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4bbd61-a8db-4b83-9340-08de08ac2149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nl2RLj5J/JXXFdjazL83fmRCEVdkw7a/lm1zQhrDyiOUSl4KQKwBWia+nENq?=
 =?us-ascii?Q?TT4r4xAi+qBKdnLc78rPSeMEJk1Jw5kHkh+OD1XjTqFp09TFws/YU58xbJXy?=
 =?us-ascii?Q?X6hhDFyIDVLtqh4g4AMi7RAthtxgXUODsvZwJdwDhHnO5ARYFZvdwDh5It+u?=
 =?us-ascii?Q?Sy/gHJ5DxGld3YmJtuuw7N4Ft+BKcHfgcJzjClI06ezg551OKWE3L/ITh+eu?=
 =?us-ascii?Q?zOH/vtvabPhBdSCdWeTaoDBCD0LyQY4oTLpykNoMxaQLO0UirGxNW5Ii/kZ2?=
 =?us-ascii?Q?KM3IUnS8uZhrSuXukTW0GmiZ25NHtZdDbymPNlv0tSc878h07JrygQWJ5h+9?=
 =?us-ascii?Q?C2JB+oJk4gIHRpvWlwVf0rohrCEX6Epbnzfp8LwUndIrREKnpDv3w5JVlmAA?=
 =?us-ascii?Q?ozNsZeyOCJfwdOd5MsmIm1KFb1xauBM2hDdqKENyKFmMiWZviGu+Hd/jxBGw?=
 =?us-ascii?Q?rN5mYOlZmXCbdsFKRaUr627O0UqBrXeBTIpZ8eJudCtOO/p0K63vsoGL5mSx?=
 =?us-ascii?Q?gaBjNqfPaSvy/QJzIscpO8JPh7ujEqNA0LgIRM8ASrV1SXDwPlVpaDSBwkJa?=
 =?us-ascii?Q?r3uCrzXik08fr1OfCMtTAtEMfU5wl86NapbLG954CwkXELsJu7MoZ+7P9eC3?=
 =?us-ascii?Q?YdUrb7dTW+L/LCb+bnt5wpajej8PkHXRC3rjOvSK+IAn7pXINDmUsZ4Tqi3h?=
 =?us-ascii?Q?004XrXygvBxfnZzCVBVdR6ikslzTghcrun05mxoP8jFNe9ArOZTX8Qncs3hF?=
 =?us-ascii?Q?otHHey9VRYkxZr9WqJEVOsC2Kpd/fPARZ6EQD9zpF6nY6KtX5yub+RCEQXLu?=
 =?us-ascii?Q?u9NCKNmy115BhkNtWKMPgb6kQciriFOW75EbWNpEgJ00t356HPnkGpbktKYu?=
 =?us-ascii?Q?RYVaHnwNqnhDIPVun1JxfYQWsrfygpJrGLntu9UDhVYFUcdLVKJqivjtuZy8?=
 =?us-ascii?Q?x6UpuYWe2uq85vsy5g28x+bXj8Q36WiJ8+CufJG6Q7rg/MQz4vn03ZfArUFa?=
 =?us-ascii?Q?teUsuoC1FkNOuZQnSidN/qrwOo6jCcFx1/wtzug6n2Ud0+mm4sEt7oUZIjHt?=
 =?us-ascii?Q?kTo4ijfWMqI3zdlt50C/AALLRr0L3TORx88NqFdcJ4itbqT2sFz79lbs3r4O?=
 =?us-ascii?Q?846u8SY4lrAJLoQCIEbSVmgdD0eFUxsCpJrYZ4jO8z2OkW1vY/vtIf4cog1h?=
 =?us-ascii?Q?83dBdg3Po4tQzBYk+H6mkDxSzjjjUP/WsiXcUvpF/C7zVfsHC6scGHAx9cX+?=
 =?us-ascii?Q?jAczXqCqY5fvpvv9DlVcv8m7pGzND32MdLeupj4YuDlcapo9p4mTNlaKebSo?=
 =?us-ascii?Q?TC0lIgKjdQ7JUrUqRraLZt0H8dwvSQujOLejTf0us9PTGddQfhUGD6tSfgR0?=
 =?us-ascii?Q?xL3O0wEErKQ7sOiaaeEigVLYiA6qZ/zOjwemexsSYgG1Fiuha9svBeb3X7+F?=
 =?us-ascii?Q?Ecdf8WI5IR5Lyt8SV5I3SWjyzejncNviuTRBPLjhhuFCs884R92On03GUa86?=
 =?us-ascii?Q?CvHEDYziIGYwIGHHyK1XbVgpVf/YbcCApzCA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qqj1mZ5rh5RFaf7wBJsW60Bor+MHSI4vVHo43bjt8j9ay9B0W+uW5B2QueOV?=
 =?us-ascii?Q?SMOxo5HL0h/A2VeFugIhiwcb9NYOfBZluziDEOMKuN5xMuLBeaeQO4dJloSi?=
 =?us-ascii?Q?SnVLg08D3no/L3hWyqIUkogr5dxPJtK8N0HUfT/T0u5bG6JZU986G5L0QS6U?=
 =?us-ascii?Q?nPMYil6+RHp5Br7Reaw51BcY0Zb2q9U2XEM5CnCThv/NLVbUQk4IrF4PFN0M?=
 =?us-ascii?Q?D9wAoMPUV1kZ1TYciSiu0Ih+HlwNIzKT8lpGX8N4dVro76esEgdTJ2a1wQx5?=
 =?us-ascii?Q?Z3m2z2kbTRABN06mUNRxCqVzIoeH0BclXATyEwabkiXSuFhGldnha5PnLi6F?=
 =?us-ascii?Q?I7ZTKvrpzliwOffgtciv8U9/NEeVDNampq6bLv99MExBCLRdlt5O51Xhy7Se?=
 =?us-ascii?Q?NAyC1BH54zE7Lu7kyaX1kfq39QX6GJCEjWBAe4E1OYv+aGh4wqV+USe25XIf?=
 =?us-ascii?Q?mV1VNMkwGP0TBpsyD8dOmS9sar6iOZpxcM06WH/xi7IXN3xLmuTRZuCkD1lV?=
 =?us-ascii?Q?PCpzInny97PpmiEgAsPqSE34e4cbAgftq9iiw5IjdmdqrKux2jdLVswKsNWO?=
 =?us-ascii?Q?6PbUS0rIpR9faZgt9TEyAuHi0aEmUvuUy9npoR6OXD6cGq3tEBiX039BCwv8?=
 =?us-ascii?Q?C0+CdBps52momIfe5R5URruaxBw8wMvkrwttXRS8GDKUfnhlfNhxFayjBGlt?=
 =?us-ascii?Q?+nMDCd3dd7RUQOG/3J+9FIZgkaIqNhgh+Q81c227LggRlWcNYIk6oJzVo9L8?=
 =?us-ascii?Q?s4MiW0piI6aVN8jv6Y+IOJBdbA3qwtVgNTrstsKoYiNKRO7Adri7heVrvAHe?=
 =?us-ascii?Q?tK6WoQk1Of8OTn5ls9YT/1M0syVqwPHNippVj1ey3l3F+YjTHYmqC3cg3r1D?=
 =?us-ascii?Q?2XMEkAuKsnEs24q1zRN20hWgjUvXzaSkX+/66qe6H2uLqqQUsyRxvvqOzqKi?=
 =?us-ascii?Q?59QwKMYbUUli/v2MRR/AEplrXvgxgczgXYASfmc2dxEHYGowxohZo90oK9lU?=
 =?us-ascii?Q?Ib3FFwRUF9JHJdEdCWFWSNgNi0n3ZHitxl8IB2j5QdDq0x+zencbDsUQYrA0?=
 =?us-ascii?Q?/yfyvX77cAwE7VkvShlD37LVr4S3csiyLPbjzNb4c6XpQPfj0OH/beLuOgXj?=
 =?us-ascii?Q?kUXeYSYMeWIXRfIDsKmchfu9hoTMhg8COGC21EwqavKhEj6ddqPn+UFuZSwE?=
 =?us-ascii?Q?R3OS1AD6cYfQfBgI5IZuKdhbUfgLIePEVVFZ3pQSCNYWdXiYclfxGoyst+Si?=
 =?us-ascii?Q?pw8pn3qRlkh+H3aWaWRYIwAlLJehMl0xLF+wB8AnraXjEIzlvpxIoSkFCvh0?=
 =?us-ascii?Q?Blji2M7hLRQQl9jMogLqZL3lvHzRVrT9HcW27FRPvOlrNFohSo63lGW/UW+1?=
 =?us-ascii?Q?sw3FWkEnTZywDfH/mZ8B3K0AGSqDYjpLC7TmXmm9UnMYmih18oAbMekBBUUa?=
 =?us-ascii?Q?yG6/EEYyeF7QvoFpCEhjDx074guflTBjhdr5wZDk34JzEtTx21T+Nnm2lcI3?=
 =?us-ascii?Q?WHRo/iPfcB6bFiuiFMMDEcin0g4sjiqKUggrZkjz0EnTr+/Fdm6U+ZzAzG+6?=
 =?us-ascii?Q?ppnOvLrKiUylCVEqZ/jlidownUoAn1v3WQhGRbhh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4bbd61-a8db-4b83-9340-08de08ac2149
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:54:12.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoIfAG/lCBkuLA/NtEx0OhMjFG4dSU4+R/TiUiHLV3ekACe2SCsNK4CJTPJ8Re1KzOphDPApqQ1rMDlVzp7yfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-Proofpoint-GUID: lNxlf5ZnlLwiL6BN1snEWB6f5xFRc-dK
X-Proofpoint-ORIG-GUID: lNxlf5ZnlLwiL6BN1snEWB6f5xFRc-dK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA1MyBTYWx0ZWRfX2MUkzymCHO9D
 /FlGVsQ1QdvU42oDVzq2Kd740nFqV7bUzjGGGxbHAdioBZeunRQgaikoo++SA2Q3/ESO9BTIwBC
 Q+rIKb9JS8KTjIldvi1rwpDxNSQTPg86Mwrjn3kC880AwlFh1XSwM03dY7fQsCr4sWAZwT2EAb9
 AaenD1dIOddYaqdm/WBpfWZ3p8dpEO8VVqDg78+5539eAo01mVy8gbBv1iKuQdXjfvnqPTIiF+p
 T8NkcR+RtJTgwQBAWODa1UWrfDjc1ONPYDwfchK8EGu7RvzlJSSHiyP8BCg6GBt7DQ+UjH/OfRs
 dpn5E4a5TmtVe3KO2sg8XUUhm+24J0vq+jQhcGOCV4uSIwB3fh7Cm/8m0wUgnE5J4fxTyI7S3My
 4pHrTwXKV9tl/AxLirU23vJMwuhqNQ==
X-Authority-Analysis: v=2.4 cv=M+xA6iws c=1 sm=1 tr=0 ts=68ea2946 cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VEM4DMpWAAAA:8 a=p0WdMEafAAAA:8
 a=t7CeM3EgAAAA:8 a=gFvWjNGKmKmW4HCM0JkA:9 a=ZXulRonScM0A:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-11_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510110053
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Oct 2025 09:54:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2290

The original homepage is outdated.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 532227a..3bc37cd 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -5,7 +5,7 @@ mechanisms itself; instead it calls gssapi routines in other libraries, \
 depending on the mechanism. \
 "
 
-HOMEPAGE = "http://www.citi.umich.edu/projects/nfsv4/linux/"
+HOMEPAGE = "https://gitlab.com/gsasl/libgssglue"
 SECTION = "libs"
 
 LICENSE = "BSD-3-Clause | HPND"
-- 
2.34.1


