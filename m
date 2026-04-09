Return-Path: <stefan.prisacariu@prevas.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09074F31E55
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 15:57:28 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.133085.1775743837187178958
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 07:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=fanV5OZD;
 spf=pass (domain: prevas.dk, ip: 52.101.72.2, mailfrom: stefan.prisacariu@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpW+GzaXIR2wRR5N+2Ds2OdZDUvN62cUYuujwX187juylJT3PGHEA4+F7/88oCULBr7zudVzk1jehd1n+yjrnE/5L+4AEH1+/jbQ61ci56I0/g+QDozVvJM4CANKSuTSFHv0Xi/NkEfUUQm9DikUY1ktrupjp7nOCnzYTLXsqxyOmYXM0PPMK471ER1FO39faPjDzFMNXnsaFBccTQ8nJ7OdI26oBF0/r9aFof2P+WArC72a/7SDxHvUx2PdGpkNuK2PPA2RAlXw/jhNI8slsLelCZfwQzgXMBgHokhIjdDOas5GKXa/x9KIR9NEsXT5JYok2RKGFv4EKObl4nMWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7KmDr4voel2XCJZMMJ06YlXrzLNh5Q/9PlUcrpA9oM=;
 b=tntIfbZQPUMQmaoY+BNB8Z9VGmSEteVwaom4DxXy9XCRuSaMqR77pEbLRfDaFAVDDxHuOAABk+xFnxE9hx+3iMLK/ollxrSlDtLpva2SK1VzF0Wr6cgR0ZjUdqdxY5WeceKVN1EZirqFFptZ81XHWFrXF3Z4rBcP/KV/iNU/aZzJiLipOG2VUKOf4l60evO5Kt2TcsTFUZPZ2vuMLzlf20APjPQEa5yUTD62RpJgN+rx2LnHUkYJy070MMr83ySYPPBuhr/c02LPqLDBqWi7SsG3yzzYJJxCOmAhfZgJPHp/NoZRsSkjlpAieD6/feDANnqvijvEzzBOWvfRPySk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7KmDr4voel2XCJZMMJ06YlXrzLNh5Q/9PlUcrpA9oM=;
 b=fanV5OZDDV2IYOjpt1EL9iyRLiv63WP8sLGY7aXMIM6LuzXKokjpVMCulgLiByxtBhJqekN/YCgyw86Eh7gjmlQ9oY/+yons83K/6k7SB+rPssiieOqQDTVWgcMhZD9GzeqPuFPnSNQSA+ygb+PqqzdV806Hzf4gNw9SjEmY9UM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::14)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 14:10:37 +0000
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87]) by GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 14:10:37 +0000
To: yocto-patches@lists.yoctoproject.org
CC: Omri Sarig <omri.sarig13@gmail.com>,
	Armin Kuster <akuster808@gmail.com>,
	Stefan Prisacariu <stefan.prisacariu@prevas.dk>
Subject: [meta-security][PATCH 2/2] tpm2-pytss: Add python3-asn1crypto runtime dependency
Date: Thu,  9 Apr 2026 16:10:09 +0200
Message-ID: <3daf5bad06a30fb05067d13cc76a911e71d094c5.1775741022.git.stefan.prisacariu@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775741022.git.stefan.prisacariu@prevas.dk>
References: <cover.1775741022.git.stefan.prisacariu@prevas.dk>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
From: <stefan.prisacariu@prevas.dk>
X-ClientProxiedBy: GV3PEPF0001DBB2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e9) To GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:326::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB9484:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: a29b9e2a-0c69-47b9-dbca-08de9641c5be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	BMjLr5354yBwD86uXIAirh7QZtOuQR0PsHf+PKhkAx10JfONhbFD4JbMuUbTncdQ4xGSxDqw1U8djngO5ZdjRegszsXnSCng8K2bpeXPeQ4hz/3xYv7+7Yc4JDvkDCk4nabkBxCKVfLLffJ/2iwqAQ78/mNVc7bUH2+mOLcS4Po433ZTvggTOjot22z6jwAPRXwLfKHBHmYoFSdYHwOqs563llJOI5yLo8tczxtPPfkvxTT/eFHJVvNTijomqXYZwKOt8zeiIgUtYZm7TA/+DMHYeq/PiLb7dEqi9sskkLxLn5gIHQLsXOmtPRbOKZEO+8b2fXaM1Z/RgGnHDiY4SB491OqYul0gqTgDuW1ROVjdmH6wnl4FwRh+Rm81TRZYo69ge/g0ZaieUo524AOyaE+rPO08vIlYy6hsa6MfaXHCwoEF238tAGcXISkOC5re/Kko/3dwcbTy+P69UEIKXVHapVEw2XpOXDRU8sv3UrsvLs+aCsWsLr/sY+1BNRSZm0QR4ROXmPU51HptH/0rGLYaODxXNeqcIa4+W+v1YPZDAPZM8LiWsZJ/JdRVZyZoec2zRUGDYLz2gyIfCJvA4Dmo9hKcM6KWel4geP1c9jMwmkyqRfL+K8ehB3hxkk+ksmfDcZfmJBYHcYz/n4fGIwK/ydggdJ/pV3ZDDUSQELJ+inEPbLbzp4Ms5N9w/nML/20joA8QHapth+YHnjBoINGzpBmAnxoPb2PyGmL4dbt9v9l7bsmwh7UCbm8uujAEJNTXoFk41bQbgbWjXcixtnG8Ub+1LmuBqb6478VXm1w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Tb5VAUwVjHuAkqglOmauM9EQP6K59WpfyC5+MmmT1x5jIrtW7eEzw5uOupUC?=
 =?us-ascii?Q?0E/IRmnuDhwm7lV73JsA8fjw27TbIGHEYkjD2VnsyC7RWGn4FdDU+Vy7YGUK?=
 =?us-ascii?Q?XUwA1mLfgVSkw8SmT62r5K9iIU61wBob4W0m/iZp1GP2L/XY1dalpabyoAnx?=
 =?us-ascii?Q?A1ZJXBN+DFDg0Cyxl1n5p+Z/N865mB9hwIDeSbFgCZzTUhqTJ6a2l8emtmGn?=
 =?us-ascii?Q?ngJ9i3P3ru8h9V3w3PnjevLaF031VpCjifsD8dlSKlRi4kDxRcyvaV6rIRSZ?=
 =?us-ascii?Q?uBlqSYNGxVQb3zfbdmGg2LMV41WXLKx9N9osK5AqHvs79XXoRCuJmwyUBDlr?=
 =?us-ascii?Q?crKHQM44drylMIvYI6PxoSP/Lzw3kYGFRV3am9DNZE0ZLvJt/CW0o4YsNwxC?=
 =?us-ascii?Q?uNkdje8CclSuVnDwv0Qv2ED1A8RbhGWNErrT88t/DPYLecf72oFcP0aQhGBi?=
 =?us-ascii?Q?YN5MSisqJAY7KU0aY+DbA2cgonducRgQRlPzaddWuKEWqUxPajv/7UV1Ykxe?=
 =?us-ascii?Q?jUR9anx1n15DB2izJtwUHdJ+4DEnzyP8dNFeP/VWdfXjqq7Kdpjed47g7XHq?=
 =?us-ascii?Q?/YXbE7ojsnWtxzlOXTLy62Cnn3WXQCX7536ITjSqrHYfRUHOkzozk/FCHJm4?=
 =?us-ascii?Q?f+plrUoaBloe+UGvurf6pnzJOnog3fC/31y39rO8m7Ix/6KT02V/OWLYBCwq?=
 =?us-ascii?Q?hRW8N9g16Y4kCNEyklQX/PdIAtZ0ruR4QMCv38pYjmfwYw4c5mpsIB1crwlp?=
 =?us-ascii?Q?r+Nsil2Xhx8BpmB4TWf7zcE4nZZTEJdTiuFuhr+MKN0Jlyu8WHul8PTWb0CS?=
 =?us-ascii?Q?E02CwwuKoXIHUky/j+Pr9uifeEPCNtgMpcWReDYD+xFu9iK57QHn2EBlOFKY?=
 =?us-ascii?Q?tge2/00Ay319EPdZb1GLnUji/ls0qXn3FdqR4vZWfOxk6c9aRMbYE0lupAji?=
 =?us-ascii?Q?MXyXaIWoOG6v8CPTwO+rigVmA8+hxB8rHUQALRvhZb8qgXQs37s7W6m2G83W?=
 =?us-ascii?Q?FIlHvJFR4plUF3Vm06VHV7IYW2dWHpmznLaHhSbTbVmT70qqbZqEzbaJdp6J?=
 =?us-ascii?Q?FuxSkhihHUL5Mv6fmQFLxsZKIwkFp4jJcIcwlhTWs07r80CM73QgmUOiVEqE?=
 =?us-ascii?Q?j7EqiUW4jsBqNit4l2GDahb6TXvbUdmENs3U1FTb+kUHWLoPi4BVTrXtinNt?=
 =?us-ascii?Q?K3MDQwFl9s0sJIv8tJVHTa3r8+eR0UmurWXK/wEazJlwnv43HjeqrSRcIoxH?=
 =?us-ascii?Q?NmsBnO3qnnbbJcfOzdja/3RAa6vXCYIEWhMunHJd7r3ESuvdGlDP4TSVlTTI?=
 =?us-ascii?Q?IQIdZaOoE6VNmYsTiYfI+EOzlih/tK+h8BjzsMub99rKSnZKqgHhkmXjCUya?=
 =?us-ascii?Q?2tSLviv37B3bOUWPp+X0Vm+uUAKDG0tfs3mAGFP09AZEuN2svnqFlREzWPPF?=
 =?us-ascii?Q?Bv5AhXTuAQGmjpTIWqdhLqlDOu/Zt4xFYJsqrIVE9iArQeCiUkDNMX13mn2O?=
 =?us-ascii?Q?1+7ZW967cyP5WVFWCF0BhKQy77FRUauE43bpVS48nWadj1jet+PIio9wDjqq?=
 =?us-ascii?Q?p25WYz8qpKBqKFbHg+I7LF8zEJuou4BDs6I36mQFuX88zN0DNUWqRziMevvv?=
 =?us-ascii?Q?rw3GaErLv0ZBm9bI8SJPMf+68rwGqcMcSGxUzdwaUzVSt8RbK4eXTd8aFNl/?=
 =?us-ascii?Q?eSkTAJUffkShqMw0VyBbQdlMDfVHid31ub/FXgUNyR649Q69YWH+2JO2r1w+?=
 =?us-ascii?Q?AeLYlXpFRSidylvUXSq3C4ISC6Hd21c=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a29b9e2a-0c69-47b9-dbca-08de9641c5be
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:10:36.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZP86EPwt9ebkRQGeNyOvuo+LVA2kb0cEC9+UfaRAIP4ArZGRIm8BsRHWAr0aY4Znh8KvzqddDZQnecIr2RbKZuAYp9fh0C8zKPrcaAYmJyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 15:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3682

From: Omri Sarig <omri.sarig13@gmail.com>

The tpm2-pytss module is importing the module asn1crypto in tsskey.py,
however, the current bitbake recipe is not including this python package
as runtime dependency. This causes the module invocation to fail at the
moment.

The commit adds this dependency to the bitbake recipe, to make the
recipe self contained.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit 75a6ea387b1f48d875ae23ed92a8346c93720f0f)
Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b=
/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index ae7dcfa..45b094c 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -17,4 +17,4 @@ DEPENDS =3D " \
     tpm2-tss \
 "
=20
-RDEPENDS:${PN} =3D "libtss2"
+RDEPENDS:${PN} =3D "libtss2 python3-asn1crypto"
--=20
2.39.5


