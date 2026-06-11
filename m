Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CBCD98CF
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:13:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39387.1781158419335035151
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 23:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=BYIhxMRl;
 spf=pass (domain: est.tech, ip: 40.107.130.16, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdqn2SUAXNUTsvt0i50JTgh6PUugIXLvi9f4X5JRZU8lgThn4cKnca+vxrLYD9jLT84TUOFSvca7enOszcahZy5+FD2mFzP0NgS/agJQ2JANom3+2N14amtx67mgHbBtzATIS3iAXQJlehxFHggKFSthTMaErKYQx+F6votEDHYjsw5PhhZ0aSX+p4s+dZFsId3/e7eiO3ojo19F8750T0zjpb1fxALq3YxX10ZR7evdikQe6D+17roMrjCsjaySvtAN0OSuJJ42ZnV2SHz2ez+l9xW7GD+EfESoILjuWMojgPKvVKrN35lCiJXL3ABGWSD1I7OKwF2tA5qgs3NHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhOv9TnWIg0C0BtGg11uWQ21+0c3cDYMXZBHl8ENEoc=;
 b=wE91bPkIObw/hLzjssrxq0Qs60EmnhoC4LiH5uxw5iIDp0oKsS7IEaJysDv1NRRQSX3P+hI5TR7d721SqHpEycWJ//rFyIhRTwNBaQGxtyLeASOE1nlud7wnil3o1M3kL16EmFK02971erDL8tqXeY+w9MikG7lZJbrkFnrtvbLX1fvyKqHFRVD7I+JmjNgAUaafY4ucNl8aoitDHqgnA4cF9JtV6mIS8LtKJaPWb6+Elr0ZRl652h47zjnn0kq1WoF8xO7cFWbf4OvLBY5y1T/cXP2wQDqVrN2ZmjeLMdD6/BIsigymf6CBw4AIimJRy20q3BaoZqkdYOjk0t2SmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhOv9TnWIg0C0BtGg11uWQ21+0c3cDYMXZBHl8ENEoc=;
 b=BYIhxMRlYI8zlabBFQVKJNtK8CwMoNGXZ0gHFMPGDBJte7/rhXLROHqXbTreGhNdxv+ZG//852TfRWFa42RKDGtOspncp6Rlt86/tYdEOdHdZe/kKSqJGTDEdl7LTwbjP4Ndz+8qAebZqrZ6QhhkAJEp4B3BcNMPMJnRpUgiMMYY8JJp0z2dLisPTl4JV+jcMmAdK8OQxEscG29cOBJ84kvB5E9v42Wfu6zQTmjSh7+PkTvLtHcTOFgBlantgtZDg4I2RWRTA/Of//IFFbOg69o2Nkr6q1ol8IAvgj+qo1ghH928gaYJPn/Ghwsquy5hfRnPz2bo5VUF0yXxDuMmyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 GV1P189MB3003.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Thu, 11 Jun 2026 06:13:37 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:13:37 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: yocto-patches@lists.yoctoproject.org
CC: anders.heimer@est.tech
Subject: [PATCH 2/3] builders: pass getproperties command as argv list
Date: Thu, 11 Jun 2026 08:13:29 +0200
Message-ID: <20260611061330.733392-3-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611061330.733392-1-anders.heimer@est.tech>
References: <20260611061330.733392-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0151.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::6) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|GV1P189MB3003:EE_
X-MS-Office365-Filtering-Correlation-Id: db9573a4-c0e7-4c17-a795-08dec780933d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	qrypek57y7T1kvOjtdjc49hiUvAueQHSTzoLEHfLQQfoYw7vyQs9/AFzhkH+ZwzmJBNiLFVj9TerF9RAL7TEu2NOSA2oG4I5njokC/zO8AurJH46/ec5d1GWTZ2itZSVife9fJkHMKhAmPXYJFv2kEhS+yPilvbcLIhQgJ7qy7buqedPtfwmXz4uXp6bxhCgxv8ZriPRtONUdq1pAsCjGmnat5qKhYmz1wczQ18rx1JkR0ldh9RxQiBscXHpp8W3jlxvjMMA5Manib5uKL9tc6lTMhzZ3JInVUNBrmdK/mDYdO474SRNou+u454ivSuBGVJ+PFDUjGGQNOaZrJILyfgQ6FUWRjR+g/wv5U1bpoaHE0Gnbfwh5wIYkjByFmbYFYOFAr6ARaY3ZBBuO9BWXl6UqnlRO94pLm21RjCkafl91z12qPdty3qXrYmt4KF1ETEcvEBx+m8wRdWcwH8WHZqnDjTxLbvCCdcWR7SHZtNzIEBdECvAgtaGGypEO4TXdPKQctKHVmzoTdNTCRp50kwqiuUi1ebe2L75gHxgO9WRSDvCuLFMK3orSESz5q+EyQ63fNMzt+ZiOJg5TvNIx2IBuR9cpckOsj76Pt4jBVZqFVtiq3eYeP5HYV4dl9f59kSBH0m1XLhCY8emU2S9raNZF0wl0bRp3kIRv9ZOOaDHwRZbpb5lRMTHwMv14ESp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nA/3yB1up4axnb0J8ihEdWE7M7WMDTanq9N7iDhc4POZfx4VeTriT7Zb9DFI?=
 =?us-ascii?Q?hUSKtoJLu+/cWkw5a3Wd+e7d+pb+oGy4IQ16iVNCPopeBvaalLabha4wCO07?=
 =?us-ascii?Q?dtuGzdEVv4HLs8ne1P9ZJXHeCBx/BnXHBigdrJmQIBN0rX0+GtOFZKaZeAez?=
 =?us-ascii?Q?7KgJZ12dEAHyEBFautYmlpObXO5PXZjtLlRfVQAyIVobb92BK8F4zrvKr2Vl?=
 =?us-ascii?Q?hP6peTNHWCGqdNiLF6Omm/YWcLReMNO8Ei/zaZumDJgCNB+mBwIqgF0WLlBi?=
 =?us-ascii?Q?ySbu607PsvZDOVpIymJ0bl123j+lfREvxF8vPlZ6XMbfcQhlgcwwtpptnZgM?=
 =?us-ascii?Q?gNcfiEr76qeBDO8Qh1HCH+mCKZpjL2rnUpqWe06H+niXhCwyCL6uxACxc5UA?=
 =?us-ascii?Q?8dsz2oBCmW3B2EbPwI+tPwu4j2Zp7v/EdzBULZNoNTUTVwZBBPmJ/XdwPjCl?=
 =?us-ascii?Q?rJl5r6GluxiP7vp2nmJvLKl2+OSQJzFXIJ2DmkxkcuS8bViPPApOVVUUY5GF?=
 =?us-ascii?Q?QzS/CmbXu2x4iSRXSpT8IUS7TGQeww6dQSlXwf7RSs9msGfnLMCpHB7bHEN7?=
 =?us-ascii?Q?J9PYiPTV7acCpOpJTCv1FhV9/ZxIfwbdRflIREpNE+nSsuvyd1Oyr2ry3sSE?=
 =?us-ascii?Q?59DiVyIlpLubeHrivugcBtQ+/38kM9aXs+YLRLG05mTikztxNgkL5P2pjvrx?=
 =?us-ascii?Q?g4v9NmpbwfuAXFWrOrI5mvEaWDwHZEt+6LGXeuO8yY4xekZ9A6vW4Qv1qBR1?=
 =?us-ascii?Q?e6uiEFkqh3+LP8cFQg69VDk3VgfIc9kws5vhhwZ6ffzoYeda/dl8JmgBw0RB?=
 =?us-ascii?Q?IfvTVY9lr9BdtqeKpNILX0EhLdvI2/RUCGwJThZpiDS86+ElpAD0Fi3DX9vD?=
 =?us-ascii?Q?HtjeH60V9QW41JCLzHoedglj0rAj6tLQ60BAtB3lUmWjHIcWUYZJ0ZEhVXKs?=
 =?us-ascii?Q?yoRL9ks4IupCjNhCeeJFx7Gw7NA1SvVpgHi1JBzFhGnXdMmcxpGzETnEtmyz?=
 =?us-ascii?Q?+UqL3SS7fo79oH599n32WDSNL/pE4PUdbsk+cpf8Lu7MssOiN0Ox8Eq3+jlQ?=
 =?us-ascii?Q?N+i26CZZxDTzVuPRNz9ArMVeeYiVVuKXgk8aR1Af4zmyugNvVEZONyaTee46?=
 =?us-ascii?Q?bqQ23188uPEY+1zWAI76kvKVXwJb8hwO1D0u/exI1tiyEH7Vv4GodGzsf3fu?=
 =?us-ascii?Q?UHDFEG2B+Z1hO5tMIKZml40G/cXHEaU84fqHsCdKm0jtbZ39t3g343Vg+knZ?=
 =?us-ascii?Q?MCPGStagFsC4v1DMn/cPbvqgfFfUOKZ6oHBmGxipRU+TrlmSjtWh6s04uQaK?=
 =?us-ascii?Q?sGn5m/GdAMOnpfDlHXNklztxrbBB5aaAunTDa36U4LXgfzJP5J49h0R5DWrt?=
 =?us-ascii?Q?osWj0HSuTto6+ZylZPRcsIvYeu+zn29hFSllJN27TyhEzSrWz1xUqA7/Sybs?=
 =?us-ascii?Q?up+By3ouFm5teIW76HnFGGdDzPl4CwKL9+SMddpD9cNzQoEpdUq7SlNDyylT?=
 =?us-ascii?Q?E3vFCyJb6Lf0BmqXSl+o32MBqfyCuLgG6n69qdsyaS2FwY+8RHZaL+AZ+zAm?=
 =?us-ascii?Q?CA+x307K3Jez5+6tOikKFv8RfLD22XLtDqfA8uOdH9OLdkjTkGLQBxm8amnt?=
 =?us-ascii?Q?ub7FRX2T4LIrLb7qDUqjEXjytVrQEYcqzATGOW6eIRVi68N3SML8UIwyEL7S?=
 =?us-ascii?Q?lTqqNexQ+4TfTcTJKp12erjgWvgbWGEkG/0EjbmWx/3m6JIfHdOhdNhQ691J?=
 =?us-ascii?Q?rTc7XVEYTA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: db9573a4-c0e7-4c17-a795-08dec780933d
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:13:37.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8XPTbmAOgsdY0tJlZ7auh1rZufDi7rKMilKkqhdknaOirPLnhGSJFCPooZ5u9BYFl2AovU/St160DrI9a1gFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB3003
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:13:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4207

String commands are processed by the worker shell, which is fragile for
quoting and unnecessary when the command and arguments are already known.
Pass getproperties.py as an argv list so builddir and buildername values
are delivered as arguments without shell interpretation.

AI-Generated: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 builders.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/builders.py b/builders.py
index 55f0769..418ef1b 100644
--- a/builders.py
+++ b/builders.py
@@ -141,7 +141,11 @@ def create_builder_factory():
     f.addStep(steps.JSONPropertiesDownload(workerdest=3D"build-properties.=
json"))
=20
     f.addStep(steps.SetPropertyFromCommand(
-        command=3Dutil.Interpolate("%(prop:builddir)s/yocto-autobuilder-he=
lper/scripts/getproperties.py %(prop:builddir)s/build %(prop:buildername)s"=
),
+        command=3D[
+            util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/s=
cripts/getproperties.py"),
+            util.Interpolate("%(prop:builddir)s/build"),
+            util.Property("buildername"),
+        ],
         extract_fn=3Dextract_json_props,
         name=3D'Load build revisions',
         haltOnFailure=3DTrue))
@@ -364,7 +368,11 @@ def create_parent_builder_factory(buildername, waitnam=
e):
     factory.addStep(steps.JSONPropertiesDownload(workerdest=3D"build-prope=
rties.json"))
=20
     factory.addStep(steps.SetPropertyFromCommand(
-        command=3Dutil.Interpolate("%(prop:builddir)s/yocto-autobuilder-he=
lper/scripts/getproperties.py %(prop:builddir)s/build %(prop:buildername)s"=
),
+        command=3D[
+            util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/s=
cripts/getproperties.py"),
+            util.Interpolate("%(prop:builddir)s/build"),
+            util.Property("buildername"),
+        ],
         extract_fn=3Dextract_json_props,
         name=3D'Load build revisions',
         haltOnFailure=3DTrue))

