Return-Path: <stefan.prisacariu@prevas.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED7F31E54
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 15:57:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.133085.1775743837187178958
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 07:10:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=laHSxbp+;
 spf=pass (domain: prevas.dk, ip: 52.101.72.2, mailfrom: stefan.prisacariu@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldw3ZeYYxVzviuss5lpsVgd+nM4LBVPICrjaTCFJrq5prcBvmmTWjmIDeYq7m2R5HERSqp795hb3Lxfwx+lzvnfyqG5wqsbgK9Mxj2I+H0ZSsBpOLgBePlN4skISZ2X5tRKdopJIBBF5/OIyGXdVcchwpWhoyThKwFhI2Uq9DuukxmSsQyY0QxWFcrOAXlGs1ZTWgMXhoCzE5/inXXY0uhXXuuqUtDy1+1rEpgMafsgX4bKaNCVGnkzaDpDiw/KtKGUDP3qL322yUyf8BvbiOYGY1AzMvesvbA9vgDYezBiZmvLCkRDFapdDYIymUeUFf3xnNuvipr6p12Ce8omJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwmJfFVVV+HJYGMUrlGb5S+9gUG9fTBlpRmorVIRpwc=;
 b=PtA1w/Ja8JSFUekM877R5Y/JTEf9fn0s18G7mYxY4hk8cITtOUyJAUL+uSPny/DRtpqXhw+AI3pZZ5X7L6qjyTSGTTdGdpB1hoJSGUpUMPVgC0gvxTnTfLFmgwrDJfw6g8mQaeNRc/gUMf0w8nyMcUokw/I9U5DxzhPmocdvcZP5eQgNDi8J1k6o1Wm3wUmzjBxQzDzXTZ3lNZxrtPAZ8rA7co7DhFnht+5KU79A/obSoo/PMfhCchYPN8AaOoNDaEzM92nnkN/ySvD+K3bVZLK9QSDzB0V/fhQQ6MvVyw6AXo/uNCxCmm4zUKtxkkmUE6QGyPLK+TSgR2DiseW34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwmJfFVVV+HJYGMUrlGb5S+9gUG9fTBlpRmorVIRpwc=;
 b=laHSxbp+AGQz9YzV+T2uYmLBvxPgyiGrrjkl+54zWjYQq9mZt2fACZbD7Hpw+r0JGl2UEJXw36iiLig0YNVtAchYW2zxQN2GaoErtooexqhkMNz5SJKviMBdPzS2lAFblj6ZqeS+K2FPbe73VUE2PWsXIpJG5OIljv4yHDJLxSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:326::14)
 by VI0PR10MB9032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 14:10:31 +0000
Received: from GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87]) by GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::76a3:594b:d769:87%3]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 14:10:31 +0000
To: yocto-patches@lists.yoctoproject.org
CC: Stefan Prisacariu <stefan.prisacariu@prevas.dk>
Subject: [meta-security][PATCH 0/2] Python 3.12 / cryptography >= 42 fixes
Date: Thu,  9 Apr 2026 16:10:07 +0200
Message-ID: <cover.1775741022.git.stefan.prisacariu@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
From: <stefan.prisacariu@prevas.dk>
X-ClientProxiedBy: GV3PEPF0001DBB2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e9) To GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:326::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR10MB9484:EE_|VI0PR10MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aa467fc-4781-4c9d-14c9-08de9641c2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	+in4vm/abk9dpiPSXONlGhA8/uc+7FJpWa6Z0b7gkv4Op4gYOVXr4oDyodQE+IgaBvAjqtix6ZqraAS0gqlI9jL+ShzMr/HWcvhkqN4csmyEYCErqWXf0VQhqYUvCAgWfxHg+ntVR0o5/9E6kfphI+g4AbyBBiCnPHTs0EuopmjdXAzejyUgk+pGGHLb1lsm5hTrBIRAH1WWD1hFM6ZH1Y/kqBgT3zo+hamp248wMQUeHJ/j8HmPR4ITWEJQuw25AmiqrosIcZzLtclJEfzXfbKpOyg2hpUdPeFTPRIj3JR6AhctnGl0pEkdXdEHNauWEfF3cp7mDCFqeAculvgjhUQmWgukIRkLtkUgD9+5zTrLwF/qPk3t2a5DbbJfJRgnQqo+9Wbn/WBRaDlGYQKbF9gyub5y3HCs0/ntOnCELRFtoJ4OTeKzXNs7fwvk0aE8X11N0nm++erlg6FC24ytx+t/DoeOL4IQXz+GfY308LCvLyZ3ZT98ZBLtutOMJr6j5nu2FAiCGsHb4wWsM+7nJK31oi3qqNpTwAWAOdeeA5ip9JjdYJZZw3ypKY4FBOfOapFKuHNNVOIxUiwolayUaUqfofgS2MnuSgwp8Ak/FNOQNhLnZNLsAiXTGuqLz4U8YZo+RIjXwtyUZaYTIqB96F5FR3v9oxviLlkO12eupNYuCTeEfvFHeRgds5WFphO0lTumGii+TZU5k2EzTpjSyecgocoY+CLXsgqdwevejuw2+zowvlSqyLt3STb85sk/UH3nT/HREIE5/w2qzUgUF0i2sPzuzwRNG6sXCUUaaG4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S686uHf+AogsXoM0FNKwmGaRKtthsx5Ueypenp9QIqTOVvsGo+MJxxzplRR+?=
 =?us-ascii?Q?H8Iha1mfzrJJwEbRrr69V+AechkwCh2u3OG9LRhyC8tdP47kOIU9IYuB00eu?=
 =?us-ascii?Q?5Ma7Pj8CfxtSSW24d+p6oW+gL8Ag3EwoheTU8C/UbdACJEZtxMwLrZGOZMAj?=
 =?us-ascii?Q?53heko6FjLNAGQeybtGBhfWEI5jGUSkSjAYKxLH5oPA5NJiO7qDUzU5WfzKQ?=
 =?us-ascii?Q?wuuZTA9RLS0rlWpQlP5ASizOX5EnwdPbs06fuR3rHfJoyy94RcEKbpkZAQi/?=
 =?us-ascii?Q?hiC2uES5ajTh0rb48jUTjuAra2nwV3cfRnlB3O+3Kw+98Bq7f/9c1bXUkbfT?=
 =?us-ascii?Q?5OoPYVh71k7pFL5Zcy9OIgmbbW3roKQRPyX5Ls4IFqU2N3Bn4DPOkyVghkPa?=
 =?us-ascii?Q?2JjBe+by3fy7DroagN+PU58sOfgQSZDOx/2oj9nWlI33lssAE9jvwIMH/LD6?=
 =?us-ascii?Q?KvNOvHpaJryq4jvzmuKZggbYatkwhNnQBUkKmeURlLQdGvVRYzHN6geYifWH?=
 =?us-ascii?Q?AktsKpsCQIXCRLneAhRhgnU/rLHwZxkhcRc47iBB+OAWXUf0fRDvswTPmO06?=
 =?us-ascii?Q?eAgjLmFIUMXU2xfCvzbPPhayPQLBZ+tmO6xc3XlYLGxZTaOo+XUcnSzax52e?=
 =?us-ascii?Q?qt6aN8wAjxeMkPr18OXjYp4WbvKNjrFJNXJjV0kAMyEhJm+7mxCoK3sbiiEV?=
 =?us-ascii?Q?yCzRpgT0oB0o6MHx2ifZ4wnX4tW98TKM3ID3ijw78+sT8fTs5+aAwuvHOE2P?=
 =?us-ascii?Q?xbyK6WX6bzIjsrsgTTlTBymRLzGWpxmzWO36yRW+kA5GhcKq/7n3hlMKxvXq?=
 =?us-ascii?Q?sIIeFXWTQEC0wgLcpfuUdJx/Mueaf5ORQnp63/dnXbv0n4bQtZqk+G8iPtDk?=
 =?us-ascii?Q?ZCvhMc42W6IfzPe9Ift7o4d+8jrpiuZyKAkluxzRS9NjB020qhcMwIyXmdAW?=
 =?us-ascii?Q?Rg0EPYXl4kWTGDxi+CZ3n5LQwBhjpsc1duUEP6PKTPZj0zcQyL8vSzZmN7KM?=
 =?us-ascii?Q?U69Dkyg9aw6oJvoX58btuaeG1v8vrqncYHJlXfANze5PPy5Oe07dm8/sEM60?=
 =?us-ascii?Q?5IhjXZKzJwpaCNNB01jwvpXU93iGXJjgV93LEVMP1VEoTWvdQZxl9c5VbQQZ?=
 =?us-ascii?Q?JcfMhyilN+tGoVYTMBTvDl8tq6zeBcmAgzaUbSFXjzMwG9YMoKk0AliPm2L7?=
 =?us-ascii?Q?+frUcbnh+xPPGzb3QWiaJq1jzp6Pj0J1Cgqhshoyzlm3H90Lom6lYcEXlqLn?=
 =?us-ascii?Q?vC+qfPgyF/XJvkD6my2IuePYBeR5nAgrnzi7GFBW1rn1prRfY46oNOnvq5/l?=
 =?us-ascii?Q?ZenkI++OWTHkvciACJxLk6V5KDX4jzrWi6kzZm3vAZ3bLus1lkWeO6mv/qAc?=
 =?us-ascii?Q?4FwrHt/Oue8hnhFf7qw3b4u75pY7vhiwYSOvd723Wm3t1FD8giTtmFXadEwq?=
 =?us-ascii?Q?tkjxOlna3uV9sUPFWHccXtXA92+6dX21rRk4vIPzg6stiaR3LAmrDPgikmmi?=
 =?us-ascii?Q?Myw5uiJ9Sc1bL8KMRLbdAKpyrqc94YDYVcL0nhYZ6uQbgXBeJlOi0GmtWHwC?=
 =?us-ascii?Q?y0ecqPDU38/iPuBDvdd9bcUqg6JrQnfd5spoEMYnz2BWwmyx2ow0z+44gjKa?=
 =?us-ascii?Q?lYwLS76BxAXgFuqLbx7r9oIBY1zIvhzptJnOJ/bWcDOqfhaWJhxXP6eTt5JW?=
 =?us-ascii?Q?1GM9G0PLAQTvI89gfeU0tB2tZlu9aS7JYA7lYcJphaMwNdit4JjRw/sVNfAK?=
 =?us-ascii?Q?1vLOIF44nEWIXMnZkjZA3qszI9XMN2Y=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa467fc-4781-4c9d-14c9-08de9641c2a0
X-MS-Exchange-CrossTenant-AuthSource: GVXPR10MB9484.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:10:31.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7C/CoYbhuumHycf8hdUb19jptqtL8lTMSxTQ1D5psuXP0fosMdFpPDPJrrOwUzmy2RRem6hSTus0N6IcWgOiSb3sf4zW+r3/3Fp1YEx3HC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 15:57:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3680

From: Stefan Prisacariu <stefan.prisacariu@prevas.dk>

This patch series backports upstream fixes required for python3-tpm2-pytss
to work correctly with Python 3.12 and newer cryptography releases.

Starting with version 2.2.1, tpm2-pytss includes a fix for integration with
cryptography >=3D 42.0.1, addressing incompatibilities that cause runtime
failures in PKCS#11 tooling such as tpm2_ptool.

Patch 1 updates python3-tpm2-pytss to version 2.3.0, which incorporates the
Python 3.12 and cryptography compatibility fixes introduced upstream.

Patch 2 adds a missing runtime dependency on python3-asn1crypto, which is
required by tpm2-pytss at runtime but not currently declared in the recipe.

Both patches are cherry-picked from upstream and are required to restore
functional TPM2 PKCS#11 support on Python 3.12-based systems.

Signed-off-by: Stefan Prisacariu <stefan.prisacariu@prevas.dk>

Mikko Rapeli (1):
  python3-tpm2-pytss: update from 2.1.0 to 2.3.0

Omri Sarig (1):
  tpm2-pytss: Add python3-asn1crypto runtime dependency

 ...tss_2.1.0.bb =3D> python3-tpm2-pytss_2.3.0.bb} | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.1.0.bb =3D> =
python3-tpm2-pytss_2.3.0.bb} (52%)

--=20
2.39.5


