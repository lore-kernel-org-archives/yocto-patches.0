Return-Path: <zhixiong.chi@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2B4CD37AF
	for <webhook@archiver.kernel.org>; Sat,  9 May 2026 04:56:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6442.1778302576306035048
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 08 May 2026 21:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GNPWYZoC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95892e51f6=zhixiong.chi@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6494j1iF2286268
	for <yocto-patches@lists.yoctoproject.org>; Sat, 9 May 2026 04:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=kn3DbGg2oF0KJL2WMGC5
	3wNfLGhIUxT/YT8vQ0sWSco=; b=GNPWYZoCzwiH0xsy7sLK9l6FB5G+qq+ycpEQ
	PCmNuup6mWmXwdHl/T1UnFmec2iLixqDRFUPJuFjWDSbVDvcXTOv+9cb21sec58R
	XZTUCSztylCfS9XkDO1ERFNavC3sVXEwypJ1MPRJhysurJzjeI9Cq+8piXojCj0k
	rS5uw4TofgV4fkrx5ghR37f8FVh6ilgXagILRU28mO0+TAizyZocyU+z69qDjSX6
	0LdMC7rb6T9dkU+g+tztt4DYg/f70nVWT8e9uoayAkwID26ct2M9NkMw0jrLvh6P
	9JQpVog/dj8ucsO4h8dqvL6AxRmFfwI0YtZgnDwrqEB7gqNtPA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6g3b6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 04:56:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njwHpgUKzSPlks5sxa+E+Hm2ij0WtEIKqz1H784iZUaL/hGsim4lyok75eLWU2xF/6iqcx0Adk8FyugjkpFWSDICqwF+UASdUONcu23/t6EhSvCnf9Q/NTry3wz6U8eH81IdB4ThT9/EFb5Pgqt3Ltzbdcn5W+R99zueHNs/g9iKihKHhsJOQ7Ydjrvp3VgDtyIsUGy5Qta4XHxGKypTlEdVRK+FrSa6VC7hLnTkzpQjSnqJP1C0nXdqebYHGIw1DZwpIbgbNk/9AESUbms7jTjkznyFXk3FXgaoILcVosIXOTdJl+BJwgmJWW3YZw/4Hcl+/ILUYkjXZx53JjJNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn3DbGg2oF0KJL2WMGC53wNfLGhIUxT/YT8vQ0sWSco=;
 b=DXyuHKQo88a6r8RgpTgDF3Bpj0EhXem85p+X0LiRLEMhwzt3+8NTGbRAOt5cHEo5J4Lp/LeCGTGu+ZMbDJ4SKo1Cq3x4SbD2sY5V4dxwMv0NtuTbT3HmlV6Skg9CqUOKq6fboZ/8nLVkbD5LeBgWnsCDYNSs4GxDGcXJ0iIwUqpHeS1nbFFCu7JVuvbkcp33Ggsk5r/lD4ZmiEdA40gdhiG0FUUGm51miL6mqd6O3CDc1DA0PSb4y/DxAkW1NCkjtTww/ICxrgtStmvXflbEBoAnUCBIX9c07QnMFEnB4QvT0kpDkNPqMIiYSqdRVyieV0VgwhMof5JCrFyec66mBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32) by PH0PR11MB4903.namprd11.prod.outlook.com
 (2603:10b6:510:36::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 04:56:07 +0000
Received: from DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a]) by DS4PPF75D68BA1B.namprd11.prod.outlook.com
 ([fe80::881a:ac0:4717:712a%8]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 04:56:07 +0000
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [v2][meta-selinux][wrynose][PATCH 1/2] selinux-python: remove all RECORD files
Date: Fri,  8 May 2026 21:56:00 -0700
Message-ID: <20260509045601.212844-1-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS4PPF75D68BA1B.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF75D68BA1B:EE_|PH0PR11MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d27dc9-caf6-49b2-9e2e-08dead8747e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|18002099003|38350700014|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	CVBg/wYodUWyzqN/piL2ddwZFVKvfJrbqp67rXjA+3tM+hNMAjkYCvGCULkA1G9NPOksyfa9NQprexd6UdReOkU66GgmmtQvxlx7TR+8eCZ0SDtbpUPvUXe9D2TvOApiImQ5iwfynCTc4a8eghU4OGiSa/yvFbHMAN2sM1s+WQej3VDGnmwB1HxGaN3zXZLp+ghuUXAOX9IXel7g9aVo7Fbcdzd/b0FSqfiBQwujv+FnyXWBLbW5dnNZya8acmRfVBdrD2+ATR8/6khDr05BRGdbzDBgvxQG/Pf8/IqdHb69BnlDyE7ecBtA0jqpwkgm86b9vi4ePhgWdlLDv4w3jXH7ZRl5kuh6AVJSspDSUwiveAnCUXPZPrHfHVqMSJgdLAHpPAsWbl2Ur0AwG4rJzQeCXXkROW+xLXtCgHEoIz1RqgjX98vN92K1Q+atmve34td2afTSzdFjCL+YxvhD616GQg8ZOp5x1VqAi7JwLc3E5dcOCWZccCB4V389HTvEMfXX9yK4uTj4jsemPwRi5P1e9mnLaXA16TruJ82M11lG6MetYtkDM+2Bif0/cg2uTNwQnkT7DFFmz7QePvytpZGAQm2evi1pvQGm4D5z8qbvJY+j7aFpzd6l+mjbk96E9xYq8+V9UJmbx2IZTftNCh81FaUVBdxw1q17N0CLSjAA09EkN0FWf1vCLHkKEIT3cEHdjv1VK0/+ZDZI05NkFA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF75D68BA1B.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(18002099003)(38350700014)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mpjzq30Nmcb2HOc88bhQkIxPCpfbEnwB6WNJ4+qwL5ajrFeRHBZ5hCn5VaQg?=
 =?us-ascii?Q?yNFQHUYXu1H+pJzAAaD8xcDhddeFfSMlb6uZdZDZZ1lBv4G5nGBFQnzC78JS?=
 =?us-ascii?Q?IGK/+AkgiEDUjxNAmlz1lVPC4zen7lmmdmu6fgz1XdZeFgns8SexPyXqbYKe?=
 =?us-ascii?Q?rZiuQWbRSCtEXinamub3PjN6SxEBnLNZ+v60gkaX7JUY5b3WYmH4J2TH7/i3?=
 =?us-ascii?Q?ePRWKvGIJIAslqK7dddrlQt71BqodRdXvgqeVeiOmXMK34dTMIQJXMiKKhzz?=
 =?us-ascii?Q?/OSN2mv/U3Nh6+lC3T7WhTR1afAQ4PMbuCbkI/QlTWW7CjFvRwuuTVZFzMwU?=
 =?us-ascii?Q?3ppobG1LwybxEx0JIttMWbgLyiaGlzU0HyBv9msWBPC/mHFEp6OSVqO01+sV?=
 =?us-ascii?Q?pOuK10SpHaKe9Tc3Dunpl1B4d1diIbh5rDZqfBLWkUYKiFCr4xIBLBMRli1S?=
 =?us-ascii?Q?Kqs5cWJIRyFiuZ/YFVer7ipXTlYO6/dVAkZHMT8OtTKY/9onHuY06Widjh7x?=
 =?us-ascii?Q?eOSn05USCworouAmK4oZR0m30jBxoPusaRPPOEzPjqWY4mVpdyPIzanj5zGM?=
 =?us-ascii?Q?ed7Fuw4NLFTefF39IRHHwybI5QHdqMnJ+4s1+UaLf4CyXa8x6nwLUDynpgwJ?=
 =?us-ascii?Q?st0UH40KsD5NpCj2yqDUNfoAylussJFl81HXbyCYEmOCcef7l6fFWxtZ4m1Q?=
 =?us-ascii?Q?qeSreAJJgGDSogigG3gcciAUcpkUkpsGfOhTgRqxG3AZ7hfxzXE3cGyko92P?=
 =?us-ascii?Q?AbPUeUZsJAjr3UEFLUed+7oVrtn4z9uu+C/P3l2+WSpXDKFs1GP8UD7GwIFW?=
 =?us-ascii?Q?ABpe1UzUL56h9xH98lfLF+94RWokdAigmM+gZayRnEuNlrQV5TDw/Pz9Ghwz?=
 =?us-ascii?Q?R6MV3K2Jl9ZvqealVYwlhLN9SzANJCjsXK9F00C85c+zEg1meXfK8rldXIzL?=
 =?us-ascii?Q?LEPuWX5okhoIh4UZ2XrS7wH2pONmjabBFFo1jCG9cDNSbaEThTz0g4bwHQMk?=
 =?us-ascii?Q?xqGPQqwYUBWRgdMSB5BodOYLZVtdQ/qc5K5Sry/odTSnhoydKyRHuoBx+KCe?=
 =?us-ascii?Q?BnWPVUj+oaJ8I9or8R1m+0XD/COLoHvP+bdzng2uGvhDNqXDzzHeSfej7F2K?=
 =?us-ascii?Q?8z8oL3p88mEOsiQ+0IQ/m5W0yn9WbXVnaTZpAICPArj9hnv/buURtOjAdZeA?=
 =?us-ascii?Q?VnNtXzTiSlJejHc4lWiUBiYd2VqZvWmvPtczNPN3yFaE1vjHj+v9W2jZHahL?=
 =?us-ascii?Q?SRrK+CmYun+r0gVYlmiyjeNLHROEhM4a0sJngQv9Jp7mOOUqitfmTsMrhRol?=
 =?us-ascii?Q?FBgXaWW7ZGlYvpIxfYnwNKyhazaa3edrO7k2iWr5Xsvb1RQTUcGFmhkPCKHV?=
 =?us-ascii?Q?1HbnKJgKdCf17gU8gRtH9V9W3y8w7q+H3Z6xjVQZCNzOXac8rR7APIrsRQ1G?=
 =?us-ascii?Q?CDc62F2SBzq8sgzVHnNbpkcidkPQT6WSEvLDD/qTapIVbjSJS0nE/acU6tUw?=
 =?us-ascii?Q?3+wLdRvpJbwcBVvrnTfYzTqV//IzrxgofEF1pwrZb2kmGrlizsn4SuncQV1t?=
 =?us-ascii?Q?sXmY4zVcMS0rTKtHuqSk14iLZR4nkdbz6dKi3ankwNGEQLVdrrSrsykUXpOC?=
 =?us-ascii?Q?+NSuBta1CCvb96ID6DW7/AzRdZiS2Mhil3sJKtCnjKYlWSwwMpieGHHl1isQ?=
 =?us-ascii?Q?Lc/fBF5k45C35FVgFioak1e0Ng4Fj/vyQemyuICbKHqVEfgWDlBVnhZNhZ03?=
 =?us-ascii?Q?WgXKf/nftq5VEOgBay35x63HkAY+k2I=3D?=
X-Exchange-RoutingPolicyChecked: 
	ShNzHAOYzobc/nsWnPMBQOU9VgDutMCwNyX37TRNaglWIT+1tedkiqK3unDu02qlyz1QJddRxuT0JfHlVb46JTNnRKuhc2N+6TuqhlPtnKCGHvIsW8XSH+ONvVggls1ZWxS+YKzuf23Oyj4PfVS+b9MuPDxLedisgEIFQvqbJJCuI6TFkwO/sJ6+t8CzKnwIy0dsVYUBFZBZhbsowAekXGkGiU2SdRfapl41ShunbbVhDXFv3VQsJU/YSdEfkGel9LRsY8JlGUyMmR5Oi5IbPlYyJQoWv7+/DtyKyD57PasDClC2L3Ot+Ed3wdgKUTIwmY5TcMVa8v66O92IOrOBaA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d27dc9-caf6-49b2-9e2e-08dead8747e9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF75D68BA1B.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 04:56:07.2876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7ue418+gp8yPx7C5hXTMtBYZnGN/ipqHj5KuywX0fEFS49Rofo9/4TKYcAWd7WKDJMh1SLVxwnUxDwra+7JDDW2zqD2SR71MXIVzoB++qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDA0NyBTYWx0ZWRfXxoG+ea817HhE
 TygGJIGh0OqJdNVKOHT2IsboGpaVB6ict5nXIWmAG7VVICB2iebYTABP8CnsY9iLR2lUDlGWAvG
 5mLkvD9qfYuufy0EPfACtrQ2UEl8iNHfItcygPBs4UisgguNE6hWjrhmmzyRuLcWXTNmmWYuKId
 45HDf61j0StbdR037MVE2m8nCs2ALKjZP0QryUnFzG525iX0p2u1xfmn/muWteIYZ/bJ8OV/nwi
 Jhk9+hXQ+zOYajKSaRUr5pWBxmENxvFfvrEKtIJjzfcoLZYTTBGOd3HKf7Xj3s/lrMQkKgMwYt2
 qPuMkTL5u6TG5jj/a1ZlnwJBSZ9DuC2KWSS8w8es7z9HYHbM7IcuRR0IhOUWQmRIHSYsMseXoVu
 xzQyxybV8ugj0ocPvWoSrbJls24fqQ==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=69febe6a cx=c_pps
 a=Q+OuU4uwq9JOSoz6MpkFfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=8AHkEIZyAAAA:8
 a=xNf9USuDAAAA:8 a=vTr9H3xdAAAA:8 a=7mOBRU54AAAA:8 a=t7CeM3EgAAAA:8
 a=qxTolJBQgbHWKOguPvoA:9 a=wa9RWnbW_A1YIeRBVszw:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 7ElKYbxAL0OyxTLH0eziXxUJL55s66zn
X-Proofpoint-ORIG-GUID: 7ElKYbxAL0OyxTLH0eziXxUJL55s66zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090047
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 09 May 2026 04:56:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3954

Python modules install metadata into a .dist-info directory, one of which
is RECORD, which contains the files that were installed and their
checksum[1].  This is typically used by pip to validate the install, or
to know what files to remove when the module is uninstalled.

This is slightly problematic when we need to do patching of installed
.py files in do_install(), as the RECORD file has already been written
at that point.

However, the RECORD files only really have a use outside of a system-
managed environment, which our python packages are.  We already have
commands to verify and remove modules (opkg, dpkg, rpm) and the RECORD
file existing simply allows people to 'sudo pip' and alter the package-
managed directories outside of the package manager.

This is not a good idea, and some other distros remove the RECORD file
to stop this possibility:
- Debian[2]
- Fedora[3]
- Gentoo[4]

[1] https://peps.python.org/pep-0491/#the-dist-info-directory
[2] https://salsa.debian.org/python-team/tools/dh-python/-/blob/master/dhpython/fs.py?ref_type=heads#L185
[3] https://src.fedoraproject.org/rpms/pyproject-rpm-macros/blob/rawhide/f/macros.pyproject#_105
[4] https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=73c49f3c00415dee99407dabba8d3b22895c9d25

Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
---
 recipes-security/selinux/selinux-python_3.10.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-security/selinux/selinux-python_3.10.bb b/recipes-security/selinux/selinux-python_3.10.bb
index 7a4b781..61abd77 100644
--- a/recipes-security/selinux/selinux-python_3.10.bb
+++ b/recipes-security/selinux/selinux-python_3.10.bb
@@ -122,8 +122,11 @@ do_install() {
 
     # Remove .pyc files
     find ${D} -name *.pyc -delete
+    # Remove RECORD file
+    find ${D} -path *.dist-info/RECORD -delete
 
     # Fix buildpaths issue
     sed -i -e 's,${WORKDIR},,g' \
         ${D}${PYTHON_SITEPACKAGES_DIR}/sepolicy-${PV}.dist-info/direct_url.json
+
 }
-- 
2.49.0


