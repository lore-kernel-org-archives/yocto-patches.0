Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EA9CD98D2
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 06:13:49 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39387.1781158419335035151
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 23:13:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=SiojFLQE;
 spf=pass (domain: est.tech, ip: 40.107.130.16, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKTKXJKXC1U/Lmczo3ztDXUposaork0k2nCwq2THZQPh4OZfEZRo8138cLUf55tMt1YRUbwJbNGu5Tr5PtQWCURsikvMuaXnKsRFdAL6zQnHL360vrDg+Fn/ACDo3zu0MbhFM0M0+TH0PE2dnl648ib4OtiWNLXGEVv+hRsgwC27hjAsEqeOnKhPISkzpOspT/K+14H3X34iDgkXHJOnwz2Kgxz6NvmEWEQDfzDmdpKhX4/vhaEh6C+eFDw7yDp55nB7ttdEAYy1dPcmJjzUYvI6dhvS4vwH8nP6cOh0EfMoGQQzYT2c3ZHebF4m+lul4EOk3yHNJkjNaIttu2ji4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJMsjrBdYAa+Czwf1FeYqJTQxMAfFcjo/Lk/eT+vRHk=;
 b=ChK8DdMuXw7+f70ScGeVgp3ZwqOJccsJmxhLL7skr/SEah96kOuM613KB/XueB+hq0RBAQkxwH0QgHcPDBSp/97Ofe5Qp/1r5PA39SsWcCWGXFGt0UNw4BRlugh3sJWkV1kKmQhH4NjSomMedv6Q4hnELSd8hiyGNC88/MpKPFt/HEH0rq2Pht3CbkncWiyI6WWgTvKWVbs0EWh2i0uUj2SzGvpzXeUBi/xzck2kmD6x+uzz4P3GAZC0VGzcNKugbnM1QmfRWizdViLRBoqWhyC82T+x6yRTfb4hkknFU1QYAjqe5zP2iMiR31uuu2e8YbDX27Ho7dp04ZRUZsfdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJMsjrBdYAa+Czwf1FeYqJTQxMAfFcjo/Lk/eT+vRHk=;
 b=SiojFLQEXeiiwn7bYcl9+M01uG4xjk8DY8QJWJRRl2YpzFSi8RF/kE61Hi0+9D4nKSqPkZ03kg6WCaLtmFC9MFPGXpkEyLiZaswCRIBNrXm8KZ9zL8EHxZKekWSGJ7/pxjxjybB4Y9a5iQzwAOew5wlzCMlTUWIM7RGNSVnRqtN3LZGqDQn6KTnPr05CL4NdHeVdfb7MYRsphoFNU/fAVQyRpdI9IzncuCbqraMoAH5QeaCQEELQuBT/DXyRBaH9rYyOX+gt+pcN56u4+Bf7aGBN6XbyJKgsaHHVvdKUPUm5kpPfugdZAqkQhJ2V0YeP250lV86GhElYqE7Yn0vXww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 GV1P189MB3003.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.12; Thu, 11 Jun 2026 06:13:39 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 06:13:39 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: yocto-patches@lists.yoctoproject.org
CC: anders.heimer@est.tech
Subject: [PATCH 3/3] builders: avoid shell pipeline for disk space check
Date: Thu, 11 Jun 2026 08:13:30 +0200
Message-ID: <20260611061330.733392-4-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611061330.733392-1-anders.heimer@est.tech>
References: <20260611061330.733392-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU7P189CA0010.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::12) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|GV1P189MB3003:EE_
X-MS-Office365-Filtering-Correlation-Id: a30d2d49-e983-4238-4057-08dec7809480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	GhBfGnjQaMFXCmozr3FVELiRbC14OK/v8MkN0vno5kEBwCoG1XzJvr3jUeekgN4HhHqryalp1gwQhlxQiZEZMrFCzRHBr+we/GTqaEZuAqthlJak8njFN53B8WZcmpuH4o1wzItxL0zlzDPw5xokR9/32csMH1Sy0alrkf7q3AGcRYFBQGwq2bL/ENmi3wDbL+mUqaRFUT5wbhHyu06xXZwYwyvKIhQVPoJXS9BnUPdp60g7q9/IW8s1SY5gGxpkTqirJg7buwILkkbJOfLtqh0FBiOydTMg6uAGwzdlYLoGiQOCNnFHVPHflE8g3MpfJdVzuxJ3GZR/Qp+MD/6GtSTB38Avqf4Kw7V/dV8fyunJGglLcHE7EycRAgzg74lV7ysCpYPp+fvwJ+FkzIg5PCT8HogMQoSwFfQlTVgso7q5NioISOhd6yQ3Os8lkrElRVH547mgF1wfpYowJhAGmo8PUZ3RWvKPIHzvp6L1U3ukI0u2FV4sBZ87rebHS0ZTaxU+hmbRsBkdvLgEdL3r/WelYpvUnPV45h/0JN0m+3DMapSky30RZgoZgVrNMFGLYFCws8vTPmJVlQi0LsZnudJtUnrAqaXC8agIq7qDuepcOMF/X9TeCSSR87UELDUPstGgdc+hTMHp8kJFfPW653gM8hhb+8WcfCoDViXxS1w9KkiW8gLt5DshUAXD6myU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5qq+Rwg9kB/ID1WHGjStSxyxNovZMbbQbbfdGg1esRiahwigDcH74703ZnC4?=
 =?us-ascii?Q?HelTHOKq6sdgN+o1Od73TC0HKnuWmIk1f6CNNCFABmEDKdbA7Fg+fBxrp4gi?=
 =?us-ascii?Q?JD9dK1b+TMX6p0ZdmwNdIIPCUCc5mGVFvvt+QDzu1LcC2Gwe5fmlT65bGkEj?=
 =?us-ascii?Q?yAcV/7ljKhMzCr5jUUSRRyPFPxQ70DwbRme0R8gAijwRfBAb4oAv237AOYel?=
 =?us-ascii?Q?B+YFcZQwRcin2HS/OgIcniZO+x2zYKwADrIJ/zaITnvji5i3HXQtaygpT3UH?=
 =?us-ascii?Q?MnkhrTHiOnRkfKhlrryzbx4nl1WpZhpPUer793ARchiz1kJzVOPFeoAxgSzR?=
 =?us-ascii?Q?6Ah5SGzpTjyVmkeU8jEDECQntXMRWPpjOVB1iDYyiVVGe4+6sZJwI41prIxo?=
 =?us-ascii?Q?nl96i1Mp+40oLOkSKmDsAVNGbJsX7vEEQUleUHdOpRQthiYtOLDh9eK5en1u?=
 =?us-ascii?Q?VEj5VgLCdl1zjtrJw2kYwpGM76mkkKsD5iyqcISU21mNuhx6Fcv2Oo8js1Jw?=
 =?us-ascii?Q?hHQLZVlHZOvTOKBbFxnFKHR/Zsysaov1gfq0KUu82KQAq3u2CectVUpme8K/?=
 =?us-ascii?Q?PvC6hDgpP7vz2Dcpdmdm/ZojOp/NklmSs4RKaEgi+CzKab392wlkjm3CBUZ1?=
 =?us-ascii?Q?1wS8xLgmqnhZhhC3x+EUc3te2ZL2w/a0UsGXysD6ZHFXLkDSq8VhPaufyLBq?=
 =?us-ascii?Q?Qg1EEDf8XQJxWxpdpXJ4vf2a47JgWRcEovzOg8fX6JwdGpMYuJMUTxGK64hZ?=
 =?us-ascii?Q?xf7DZBWMTUFVlRCMaeqQ75pHg3a6MmxJtHl/ek1BHDSEbfCCJk18htYf4Kb3?=
 =?us-ascii?Q?W/ZjlTnK8vMYPNTqiBXzrY5kjiXMuSwOI0DxxqBNG7H0roayxLdC3XqXUwAv?=
 =?us-ascii?Q?QsK31A01IkNM5s1bUOXZ27Tf64ak/63EokLgo0eV1MwgegRHl2lO9WSucrfc?=
 =?us-ascii?Q?KZ45sZNlNg2brz+0XAA4ul404hotu96AxjEPsRtlK5Ha7UpCM8NLkYR5xKE7?=
 =?us-ascii?Q?R2yDCMddIDy2TQnH+Q7LtaAAn/D5N9zdyKpc5qZVpMtScYQJjtWbAzyIfv3F?=
 =?us-ascii?Q?5tIROrXrNWISznM8VFJD8UJThzfd6pR6AaSpy+uiphIuaGt7PaiP0PFJ0SSf?=
 =?us-ascii?Q?ZgBPf8z2z40lelQmyUAafCKHXmNwIzCVhQKhPs5BEjZlIZ0feZ7xr9Ss8MAY?=
 =?us-ascii?Q?qxwyMi1zofDhCPGkyAvzSRyPNh3OrTGp0gszqXbZ/tJr6bPuF1+Z05dH0Sqe?=
 =?us-ascii?Q?5SXa2MWL2gaxOth8wTEL/pyhUeGoUDA0ihykI7gBRDwx/RwLYLUfY/u9cj6y?=
 =?us-ascii?Q?xGv8v/KyO1nFaMM6GmlQMcChfHqGPiWxqRJD6iMMbWdytCa9JJcoAy+T1xOp?=
 =?us-ascii?Q?1gp8QQPty+uvDDgqiqCOOv8kimtGtv9PF5t8wQGxuXciXgFoACsYLp5wBY05?=
 =?us-ascii?Q?CUCvCf5f66PD1SyAbdtIz/Eo0rSU4XOZo12RVpUa8zFW4b5S0Oz+J1pNRiU2?=
 =?us-ascii?Q?Up9NY7d6DwNDPzZteMwkiAr7j7Z0bXK9gwI9HH9+ZvZrgCfKsJpOAETXM/Wi?=
 =?us-ascii?Q?jnz0InfPGsSUlSrWO/zey7+pdtvKS8SuZySgKTkb2m3tIZ2HRUXNcU59Idlw?=
 =?us-ascii?Q?QkVEEZBhapy4RTR1sUYXBUynP6j5OcS7bGRghpErtSp/5KiMgDG5RVLkzFdj?=
 =?us-ascii?Q?wfoBcjpRP3OwHS7khkVJBXvWWdwttsB+WoNfMRYmVAH2VBavlUEr9sV1oGZ/?=
 =?us-ascii?Q?V6nZj5rG9w=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a30d2d49-e983-4238-4057-08dec7809480
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 06:13:39.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oNpCaVD0LSA7xgSrLaOic1Jz7BajRVTTqfcFFnAhBlZHyRPionpT1quLZhgx58QXJ1nPixpnYx5NKig+pFrNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB3003
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:13:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4208

The disk space probe used a shell pipeline to run findmnt and awk.
Ask findmnt for the available-byte field directly and pass the
command as argv, avoiding shell interpretation.

AI-Generated: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 builders.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builders.py b/builders.py
index 418ef1b..1b65e55 100644
--- a/builders.py
+++ b/builders.py
@@ -81,7 +81,9 @@ def canStartBuild(builder, wfb, request):
=20
         bytes_in_gb =3D 1024 * 1024 * 1024
=20
-        cmd =3D yield shell("findmnt -T %s --df -n --bytes | awk '{print $=
5}'" % mountpoint, wfb.worker, builder)
+        cmd =3D yield shell(["findmnt", "-T", mountpoint, "--df", "-n", "-=
-bytes",
+                           "-o", "AVAIL"],
+                          wfb.worker, builder)
         space =3D int(cmd.stdout.strip())
         if space < threshold * bytes_in_gb:
             log.msg("Detected {0} GB of space available on {1}, less than =
threshold of {2} GB. Can't start build".format(space / bytes_in_gb, name, t=
hreshold))

