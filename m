Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19048.1793386637257096884
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Oct 2026 11:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HADSsB8H;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=57637de7c6=sunilkumar.dora@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UIujnT2899701;
	Fri, 30 Oct 2026 18:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=vO6fA+Q2j
	LQjauUvljvznt/Gr72QYmuUivdZCmce7ew=; b=HADSsB8HaGoPhLvPCiRJEUdWX
	Q/VHIdqORxiBCvVq963QKrqJUYnpqXIlUWo4Qj1SmNKyRUgfCuRAK6V6KUk8eVmn
	LfXXFU+OBO702UNU2nCEGl/xDov0CZ7Kpzo3pcF3bTNFhbNT/Npywhzplgj3laNu
	kQ14O3IQBXYDJxs4jq1NU1i6LFgIMzLdZB6uwLonyYdvHEo4vPcTeycN+TsRFjOE
	PLRkeVRIiuTk5dF9jeOMNnNjrSGmoOoTkpq3nYJvWHwSLjfWAeAycC1pISf9SSMf
	2ygXSLcHcaurK4tPP+B1bg2vnWHYrd4tfG0q6rDpUzhLFJ+tJGQXMfD/QSZJw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11022127.outbound.protection.outlook.com [40.93.195.127])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4hme7f9gk5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 18:57:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMgyHO5iR9d2mAQMFUQSyxSnk0k7ohLm/fwbEAuktlJPRfj9B2a6FmMGq2Q5Ds5A1S1h71DOf4DAyVB3rfYO8hfdwnOJa1V8I0HNFoILtEAQlLGMe+m1DZEhlyEjX2SymiQ4DNt5KwllZoeWo0M7GoQROOIOgs7XBY0Z2XcYhrEiy+ry66yYvPT4BZpkZAIl5A7UthQPouHehktkUqEhwuyYykVtld0DG3hw1WIxGVBD5HEMdYGqBNtQQ2aPsf55itDMFqHpQiG+BrEB0/xdXSZ5CF5CbsZOXaXoyKwmj1Alq8bcTbA0/JP32ZRQdNbkU8DPoDRsNaM04LPPqqZ2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO6fA+Q2jLQjauUvljvznt/Gr72QYmuUivdZCmce7ew=;
 b=TTSl2isfuXW6Rdfast7BYG4d9Pg94w1OGaq7LRm9+/fmHNiRA9l8O9hgHivdTuLhrw32iBYpVP2a/lRTZT5S9lPoPMr534wEw3p0xRSJDiVpCkEabxVet3Fq8KP4SRBSzH6x9XteFFdveiVa7V5Gf16RJzsULPlss7yuziMbSG2I9xo/aiptaX6LnM7b+LosRL+t34kVHSqCsUAX345thidAQuFi5UA0PwbBod4X9GiS51pANMyyisGS2CJ/a+taLuKRH9UXUc57iCNpYs5AAFi1XsFa1KN5EUdtC2CMRE4t9L+j4WPbZDBkNImvIMqxUze/xl2S8gxKCSb84zbUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from DS0PR11MB7901.namprd11.prod.outlook.com (2603:10b6:8:f4::20) by
 MW4PR11MB7128.namprd11.prod.outlook.com (2603:10b6:303:22b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.8; Fri, 30 Oct 2026 18:57:05 +0000
Received: from DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f]) by DS0PR11MB7901.namprd11.prod.outlook.com
 ([fe80::4293:7c4b:a0b5:eb5f%3]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 18:57:04 +0000
From: sunilkumar.dora@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: mark.hatle@kernel.crashing.org, richard.purdie@linuxfoundation.org,
        liezhi.yang@windriver.com, sundeep.kokkonda@windriver.com
Subject: [pseudo][PATCH v3] makewrappers: Allow the wrapper architecture to be set for cross builds
Date: Fri, 30 Oct 2026 11:56:45 -0700
Message-ID: <20261030185645.765144-1-sunilkumar.dora@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To DS0PR11MB7901.namprd11.prod.outlook.com
 (2603:10b6:8:f4::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7901:EE_|MW4PR11MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6750e1-6318-4152-20ee-08df36b79668
X-LD-Processed: 8ddb2873-a1ad-4a18-ae4e-4644631433be,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|52116014|261028144727099003|38350700014|56012099006|261021121427099003|11063799006|261022105027099003|261026121527099003|261022075727099003|261021123027099003|261026140227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: IqbfGAWEu8vGFVGHFA3oO+E7d7lKVZkiF9ohKDWcJ6uSrXb+AkugxhfQHVINJhtV09Kmha/joCMxYsJ/0WsNUGSoGaOjWBqZMxgkqzoGSC5QRlLoXs/gmVjVKNCUX6rV1FBNVCc4dLTx2h9J9EadlPPa7MhdS+ujKdxdTxva3JVL20cV7h90ndh7lY1CEIHvPSZjE9PAgSys0xdYzgr/WWpwOn5VGxunoXZ7RIzL4JIQnoL7rQgpFbU1bcfkc/4z/RELFf0z3ufidEzxVDXv/OSJzB6agMv2FTGTckwQpgKBCOrvvI19KV8PHaHeZrGfNyvUhz7/lx8f0G3My/8dhJwUcyPigJu4o++CXztg7Djy4SANxKlFjPhrtUUIqEF20rfo6evM2WsENHoCoW1vGHTqiKiJ3y8Fc97oGlqvuKVyQ+ENWwOD3zVWY8k7M+38Egb4POm37Uy6rh0W8u9JRsxpjvgL6SuCo/ofWQfI2u8zBG+OHPaz4b9/uGbAeG/WWpyJLULH5NAvVA2nzUo5U1sd2Q7YXY9dJZxQNrLTo+AMeVvlESEcpSgc1/jvuHNoASQPGNlhpwXqRCgfntsRAexQygaNCcQxbuLkxDUBqz96hxYukuKK9iqAc3Kjp6xUCGCVNwdb1UDTcSxtqKSvtHwPrh/a0xr54o6evujUbGCe/t3rzbGQDPXrMogAGhU2nrV7fXO6JUqhiPekZkA3olsB/G3IZTYQF9tZo1rOYfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(52116014)(261028144727099003)(38350700014)(56012099006)(261021121427099003)(11063799006)(261022105027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261026140227099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5DHzOktu97M53H6415H5RjfPStkRH20Gj2oQEUV5L3+9cpPD5FaRINJEpqDU?=
 =?us-ascii?Q?DvEl1RiSqg0Pxuaa441nmVFZeDv79ZrFlvmT56D69IzmuG20RdFvTUOHggTu?=
 =?us-ascii?Q?Lp4KortiDMRtB/7eN2bMzjy6aXRBqldn49egHyRq3NskLTPS7K7Bny+vTp5H?=
 =?us-ascii?Q?Z/1HGgQ1CiQZhRNIs0atwrnMODhuOHcQ4gC2vLJYLPeWOydCh2pA6ZS/QRO3?=
 =?us-ascii?Q?X5MOvOOIpJPjpXaAui5QRKG6Ys7xh8+o70OhewRr6gT5XksnUiQfOhmlCAQo?=
 =?us-ascii?Q?qKQLmqhWgiyeX7cGyTfU9qX/0bYFmwSIS28/U+aK9h8o978b4Psxto24Tuzi?=
 =?us-ascii?Q?EaqIaxu4UzGZEEE4edkqelmVDShz9UNAId1Fw5jJjeincuQQzdjmRRTQRoAN?=
 =?us-ascii?Q?bYC1gfexEiuLCX71TQEKLzc45S1y1m/gSCyIByI5QFTm7+Kquc412kw2GI7Q?=
 =?us-ascii?Q?idlUfV7/rT81iw+8/vgWdUPfPwffo4Y2Z5/Y7WW/5T4oEh+6fRKVobwtbft4?=
 =?us-ascii?Q?C0zBbSPbv3mcmrgU9/B96XKu4XRVtjnsATb7cNhvFXii6GxF2FXHABKoRjIZ?=
 =?us-ascii?Q?wCBxgb3a+M80Um3yrq14xBXhRgois49eaXQZRm3hWQhloo/oaJuyPye4A/zA?=
 =?us-ascii?Q?KRD4cP2mk6mPmjOardIvKOR4wMOysW2IDZKQf4yiwutei87nuxO4EvxMBEav?=
 =?us-ascii?Q?uEXBqA9j1TV3NZHHeQksZpe5nG7V0ExS9v6gtboyyRyKHJRPp5MVZ7ak6SNi?=
 =?us-ascii?Q?yvjU1EAAHP0YF63g+lNMv1dbgRvoLD+BiLmmx1r4zv4KxhgkJGa0KuhR0Fwq?=
 =?us-ascii?Q?FuLPwNzadn6B64FVCqTOFI2Ga3OHQdAW8whO/ZyaxK9jS85BvNBRJJ61qbZT?=
 =?us-ascii?Q?3N8+l2ezQT4mjy3nuUWNLsUku/QQ0VBv6oWObo41/h5rQTt5MsBdm26Wq+Pg?=
 =?us-ascii?Q?zrRUTHJFtBFqY5LNrwy1Rw9TOi27+t1Dgx/LbQKWcVN7fDgirmcraK0jdS3v?=
 =?us-ascii?Q?dtrnkwk3Oj4Qkz6rNiz3OV9fpLpakIVfgSjeiDypUN59DStIuq8XCdQNdbHv?=
 =?us-ascii?Q?XrdRC1JqrTzFWApPTscL10J2plF3xrgiTHVEHAVRD9DPi0FjeZz1s6ZW1rrt?=
 =?us-ascii?Q?Fsns8dLKsZYff9H7n9cUDKbaPLvcvH1co0uiE67Rh5//FfvtTqM1dpt7bFqu?=
 =?us-ascii?Q?vqEiIaJPT+WqnXq/SxG8L2fGWJI4ymV9py3tYVtw9nnncwnD3njKNHLvAABV?=
 =?us-ascii?Q?BvlnxMteREpZ+vQ8qN7l0tUo/sET8mwcf24EVs0uZdB3uF8UHOHhvSubdAuf?=
 =?us-ascii?Q?uXQiDRM2S6K4sFe+UemE59coFsMSSb/yWJaB9ydgmUlj+sYJzZoA2RDu8JEY?=
 =?us-ascii?Q?TOpQsTVTYYHTxWTxaodOENlJJRZchGcmLF25h7e3mQC4V5MkUlPxkyah/c1m?=
 =?us-ascii?Q?CdHCb5wxDUb2B736LG4/Xq+lJ2DMz8OZ2dH+vRlumOExdSyJT8C8LC+JTCOo?=
 =?us-ascii?Q?8LZazOx/XEh56BGpLnTmblAliPNDoUC6Qzf5K/41XPYA+5fn6wg55WormqB5?=
 =?us-ascii?Q?kztV90zI/TgksL41KSwvNdCe1WWoEJ3xQbI5PYgq4/ZgT/1qs1jCSWD9g8D3?=
 =?us-ascii?Q?KVJoA3cHWCEF0dTxyBGR5wghiBnC9RlKFQIKb0JAUmOBSEaG8mrlmG5wTJOP?=
 =?us-ascii?Q?2Z0KJOjwCfIslIiE0XqPzyCwNW5otCNYM4Ui9erZjVU/29pJV8fn18yZ4/7v?=
 =?us-ascii?Q?Vt7ljo3Tlf+/88t+rZCvk8/vfmimx7k=3D?=
X-Exchange-RoutingPolicyChecked: IZkMIqON9179jIjNM1k+64jYLQ6WSiECMvCOc1hgSYGrm51Qk9sPFoVGXW5UVmvYWnxWQwFyFvLc1P0RUdsRAmfbZqdqBWoscZdGM5pkPUQcdMkt73wngT4pHgizV1Gw0vnPXZ6tI4xNal59vRYMf73EYtgbzi44++WP72GQwcNKsP+e29B1OQxqTgV8LOBaWOOfEUoz4nMVmzN1GbiWSaW+2Z3SAIRm3YG3RScKEtXVZj26vaGc6569/PaViO0E1FO+9lH9Z9zxYkIj3CgNq9r2g2OtBmfn3WqOrBOZsazisoiRRHVTWkaz/XuDVZiN+GiVm3lhvYjvoXW6UBuXgA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6750e1-6318-4152-20ee-08df36b79668
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 18:57:04.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ3ZB7mpAuRoj5YLUG9XhZkDtEItuk2j+mvXX+Lc7EY0fvBeczBIoQRRG1DQLgQes+e4jAoiflRs1cM81tynUzOMWPhyn2wm4TYMg6/mLxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NSBTYWx0ZWRfX8x9x/6Wj0QF8
 cnJXIhfgI+7/7KVvGVEmOMrJo9ptXzR8tnL+ic2wwJaJIhEG+Awb1a/UNAbHfTojvpkxqa03rCR
 fnIXkZHvhWd3ekvu6ojejJg5t3If/e0bKDD0vz+gzZ3syzL5gaAA/wfgr89gVwX0As7r7QRPUSi
 LiRjdtI5k8kh/oLkZa0Of5ehy4ID7jVxTgIZMvVe5byghCSDKhWbHvxkp53b1PGV1F6BQVwUDxQ
 XQ3Lbsniysw2VoZGYRHHGjCjf0qJOieXhkPrfMTX19iU602z27foKXERhK5OrBCrx6DMyfxUiiU
 a9ZJUooOtsq4s1IcBa+WViyBLiJFbCMyoDZHQYcEulIvnnfgGju5x1turAnLdLwDWYaYKa3smiW
 VikPbZgrfIs4BvE3diZrq5WyzDbTcKElNmJ6xya2A1iqH2340+VT/fm7VU1fd36g5AKuijyzxTP
 XrNYhL1JAT4+wbUWLfg==
X-Proofpoint-ORIG-GUID: 5skeTWLDHUVZZSNpXU76rJaQzOBTnBih
X-Proofpoint-GUID: 5skeTWLDHUVZZSNpXU76rJaQzOBTnBih
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NSBTYWx0ZWRfXwGtP+3EZKtus
 P2vOu5JszGwh5Sd+jjS+XS0CKYvOUMIMYK68MgbCzEWHx0eBWS2KY2QazqcvGJTSioBs7xD+Bit
 R4CrgtNnKpP8C4bfY3ERWS9Jmj/MWQIgkCy3FfYNMefvO/ERnkaU
X-Authority-Analysis: v=2.4 cv=AKC+DP5v c=1 sm=1 tr=0 ts=6ae4e886 cx=c_pps
 a=4J2h7sJdpVYe1tCXGSmzzw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=HQp09vvjJnJxfHRkxWAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300075
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Oct 2026 18:57:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5191
Content-Type: text/plain; charset="utf-8"

From: Sunil Dora <sunilkumar.dora@windriver.com>

Architecture specific modifiers in wrapfuncs.in, such as
version-aarch64="GLIBC_2.17" on the xattr wrappers, are selected with
platform.machine(), so they follow the machine running the script
rather than the one pseudo is built for. An aarch64 pseudo cross built
on x86_64 ends up with GLIBC_2.3 and the reverse with GLIBC_2.17, which
shows up as pseudo not being reproducible between x86_64 and aarch64
builders.

Add a --target option to configure and pass it on to makewrappers,
which uses the cpu part of the triplet for these modifiers. Without
--target the build machine is used as before.

[YOCTO #16376]

Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
---
v3: I missed the [pseudo] tag in the subject.

v2: use a configure --target option and a makewrappers --target argument
    instead of the MAKEWRAPPERS_ARCH environment variable, as suggested by
    Mark. Without --target the generated wrapper table is unchanged.

 Makefile.in  |  3 ++-
 configure    |  6 ++++++
 makewrappers | 17 +++++++++++++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 6640a73..9c6da77 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -34,6 +34,7 @@ BITS=@BITS@
 ARCH_FLAGS=@ARCH_FLAGS@
 MARK64=@MARK64@
 RPATH=@RPATH@
+TARGET=@TARGET@
 VERSION=1.99.0
 
 LIB=@LIB@
@@ -146,7 +147,7 @@ tables: enums/*.in maketables templatefile.py $(TABLES)
 	./maketables enums/*.in
 
 wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
-	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
+	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers --target="$(TARGET)" "xattr=$(XATTR)"
 
 .SECONDARY: tables wrappers
 
diff --git a/configure b/configure
index 68c9962..b43809e 100755
--- a/configure
+++ b/configure
@@ -10,6 +10,7 @@
 opt_prefix=
 opt_libdir=
 opt_suffix=
+opt_target=
 opt_arch=x86
 opt_bits=
 opt_sqlite=/usr
@@ -32,6 +33,7 @@ usage()
     echo >&2 "  configure --prefix=..."
     echo >&2 "           [--libdir=...]"
     echo >&2 "           [--suffix=...]"
+    echo >&2 "           [--target=...]"
     echo >&2 "           [--enable-memory-db]"
     echo >&2 "           [--enable-epoll]"
     echo >&2 "           [--enable-xattr]"
@@ -153,6 +155,9 @@ do
     --suffix=*)
         opt_suffix=${arg#--suffix=}
         ;;
+    --target=*)
+        opt_target=${arg#--target=}
+        ;;
     --arch=*)
         echo >&2 "WARNING: The --arch option is now deprecated. Use --cflags."
         opt_arch=${arg#--arch=}
@@ -341,6 +346,7 @@ sed -e '
   s,@LIBDIR@,'"$opt_libdir"',g
   s,@LIB@,'"$opt_lib"',g
   s,@SUFFIX@,'"$opt_suffix"',g
+  s,@TARGET@,'"$opt_target"',g
   s,@SQLITE@,'"$opt_sqlite"',g
   s,@ARCH_FLAGS@,'"$arch_flags"',g
   s,@DEFAULT_SQLITE@,'"$default_sqlite"',g
diff --git a/makewrappers b/makewrappers
index 19508fa..7cf2862 100755
--- a/makewrappers
+++ b/makewrappers
@@ -15,6 +15,13 @@ import platform
 import subprocess
 from templatefile import TemplateFile
 
+# Set from --target=, empty means the machine running this script
+target_arch = ""
+
+def wrapper_arch():
+    """Architecture the wrappers are built for: the --target cpu or the build machine."""
+    return target_arch or platform.machine()
+
 class ArgumentList:
     """A (possibly empty) list of arguments"""
 
@@ -319,11 +326,11 @@ class Function:
             # Strip all leading/trailing whitespace
             modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
 
-            arch = "-" + platform.machine()
+            arch = "-" + wrapper_arch()
             # Sorted so that versions-foo appear after versions, so overrides are easy
             for key in sorted(modifiers):
                 value = modifiers[key].replace('<equals>', '==')
-                # If the key is version-arm64 and we're on arm64 then rename this to version
+                # If the key is version-arm64 and we're building for arm64 then rename this to version
                 if key.endswith(arch):
                     key = key.replace(arch, "")
                 setattr(self, key, value)
@@ -669,10 +676,15 @@ def process_wrapfuncs(port):
 
 def main(argv):
     """Read in function definitions, write out files based on templates."""
+    global target_arch
     funcs = []
     sources = []
 
     for arg in argv:
+        if arg.startswith('--target='):
+            # A GNU triplet such as aarch64-poky-linux, only the cpu part is used
+            target_arch = arg[len('--target='):].split('-')[0]
+            continue
         if '=' not in arg:
             print("Invalid argument '%s', must be of the form name=value" % arg)
             exit(1)
@@ -702,6 +714,7 @@ def main(argv):
     port = Port('common', sources)
 
     # the per-function stuff
+    print("Architecture for wrapper modifiers: %s" % wrapper_arch())
     print("Writing functions...")
     all_funcs = port.functions()
     for name in sorted(all_funcs.keys()):
-- 
2.49.0

