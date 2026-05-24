Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43965CD5BB1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 18:23:31 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1694.1779647007691442406
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 11:23:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jXOgV75B;
 spf=pass (domain: siemens.com, ip: 40.107.159.52, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQrRdQZq2RJrStMUMMqITKsmH8TRui1kQt3R6hphYc3JQvVy3zsm2gY6C8mEv7PHGAI77xPrR9aqwdTpoxuYcG0ZLkk5Oc+s80kZJqo0NS4Mvqun8KDA4LgXRpTrHnKPV8HnCC1zd9GrDRnQmi8VfIOZUVefH9D4DD3YqzPTAmbMp5PsvWh+wXoS1ObnXCiiMBdvKPQnnpJbwMfqKhVASx8gLuzD2R9Ig05esjEfvuQ9KTBQREyV7uSs7ildquzhJdGhjFsYTNfC0Xp62nmyXBblPj/nc0rP4YiKhTozY6gMsz7xj6JdyHJKIL+/wZ7XndTKcXtctIlD+OIQIgmu9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe8aix8Um+Umow/Pf1P4kG88R5PTtQpGu5vA8phiFQY=;
 b=aVvdEZDb+aLXkp+yRNiZ+//v4iRauheClIcFdAgZjCsogUUe8nfVU1Y9CA0hXiXHFFPiuEy3WOq7n/UaAvDgTBjNe/IitEV1G4nltZ0Fyvatjm7IzNfAxvSS9IMd2Zmg+wKnK9nutuasg7MEGuMOnGs1ED/FCvJV1kvJqmoiUQYybjyxZCfEJLQ2aqpubIKbV2D2bnCLm3KmP9HuY9rzLxK6IpatdToPk4H3E28DSNvSPTqCa5OuRCKk3a404o9ZXUUSyyGafkbyuq0150K4XGkS1jOAz3G8QUbyW0A2h88AMIy1nVL94SJf3WuMcjW89+PVkSVsqpwyKQRFpnThIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe8aix8Um+Umow/Pf1P4kG88R5PTtQpGu5vA8phiFQY=;
 b=jXOgV75BIFzbbOOewX3g7oQeUc+a3J0wXWwaTY0epJ6NHE3rkwFNuowkiH3fPqeLNLa7DnkUyN6oMgmZatqFJ7YkUUcMp0ZKQS8nxAlwKMZzNMSgau4FQWTBVTGkFt0xSf8UhB84rHqsOU5VRNtnwju7yoEHFCW03yLAroeb8BX7tUioiUzde9FRf1aKc9E0Qqg4B8htkv4UmDqXfKmLsoj6RxZOj9lp6xUwHYOvrOwD/uyCjeOdzv6adfp8HAbn7QX0kI1jI2WSmrpkM/wl+CiYcr1r7PCrKpA7zCfceFAUFtMDJgc5nD/tquWTGSNVg+O8p7x/6/hqhDHBWM09Gg==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by GV2PR10MB7560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 18:23:22 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%5]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 18:23:21 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Scott Murray
	<scott.murray@konsulko.com>
Subject: RE: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 05/24
Thread-Topic: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates
 05/24
Thread-Index: AQHc63cWZMtKKmedb06hf/fy8EshWrYdfWkw
Date: Sun, 24 May 2026 18:23:21 +0000
Message-ID: 
 <AS8PR10MB507361D4510F0DA1C870E1E8FD0D2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1779624335.git.scott.murray@konsulko.com>
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1f25e003-aae3-4d2b-82e5-4efd0f87fb70;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-24T18:21:43Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|GV2PR10MB7560:EE_
x-ms-office365-filtering-correlation-id: 02eabc5a-f736-46af-e52f-08deb9c1896f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|22082099003|56012099003|18002099003|38070700021|55112099003|6133799003|11063799006;
x-microsoft-antispam-message-info: 
 XuSEwq0ZqvKwCRr+xsozFOzpgta637Rxp3RfFCWN3gvPAC9IpHdgDSJIMJOMpzrbm7EQZSvb0Ho1fImn/4MudW8gszndxxK0NxggjGWxKCCoSWsKkIpmFtFWgVSQ1F8av55O+0mxEibe+CKh1DU+R4IYE9Fb6KvQUy5SXNwKXM21DroU60VEV7TpxBuAyFVGFRvj9IyDkv8S4eBjtmyvEpiAvb6IAjb7czJTksb44aSGdZANH1LHRO6w4GoVOQYvN0aanU21QWit4DX/PrC0jtlQmM2fNftmO21nnGMs+AD3mK3TTHXUkb7F/0I84qNIyA4e/kcZeeKsQAFORrhIluXXgrExk7pwcWde/s8YRs7zvCpOWozTyrnT1Leu6/OC3NhHIrbS7D0D2fmNcjNEAwUPngq9RwVNnyIdsDNTO/WZR5IYIHIbp2HZLiVY2NlqFvRuWyqYU8qaPws4ZM4i+zh7j65WnuiV/mhEzoDvBg/cBms5y29CRQkF68LWEZga3HgJTU2W5pTQw55rmyykx+XwPW1efALgG/dHTBSedxZ+FjAM/s5bsqIWxz9lZgqKLdyOZJ3pZWr5niEJahEG0H5fKn4PUCd4Qs4cqqOT0ZJVBuKTGyz4/wWoX9hlrgWSssuhe5Ycwrmgb/+sUy/kCOKpcunzktr1MfTnQJqaqEiFwieV2WM3N39KnGEwEDHKvAiuoU5S7dif9Y22pF8VNA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(22082099003)(56012099003)(18002099003)(38070700021)(55112099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?W9X/IdwEyvp9Qu2Uxa6yAKxdk4tpyxuKlod8SbdEI2yCtVSZDSLB+zkMX2xK?=
 =?us-ascii?Q?kDI6FnJBS5o1O+fuITARSGXOxgSz3iFOu45Dv8W8vTsOEWlS0BhZuBlShIbM?=
 =?us-ascii?Q?YA4rSgPISO2xH9Bn4kWErIE0UKlzJsmRZohj4qnbNE1DD9S/Jw6M8lcPn27Q?=
 =?us-ascii?Q?nXKXBFq2x441NNmoNI+W0my6dH1Z0u7d+itscI0o3kz43x+GFC+KHHyJqFCu?=
 =?us-ascii?Q?JYrVRU3hzsuSHAdYzRu6u21c4s9UX6vSf44o4947sAHiW6Z0aUDkre1B6HwD?=
 =?us-ascii?Q?V7RWfaMnGVMcNSZ6VOzWaJ+a/mER6GlSfSG6+T//qvGtLRWH7h/8TwiVqmUY?=
 =?us-ascii?Q?Nt77dMVt5nBAPj5IWWzC5rlHiaz8nUJlYP63qEUlN1rWhX7sXanjOtAT2hVp?=
 =?us-ascii?Q?3pMCLdLtSUEalkp+iwRn1976lxX69JR+o5kCQDLd+FGGBYprw3tYgiqd1K/7?=
 =?us-ascii?Q?B/eVcf30k7b+hIcVO7zM+TniGZ0Jw2qO2rBWz+NhyUYXRfqINzlJQHgGr8BQ?=
 =?us-ascii?Q?ZZvqCkNV1CUMnwHTuOckqb6bYR5TIBF45EWI9DZU0Y04aTDJ9lOqzUsY4Yir?=
 =?us-ascii?Q?xcLss5o6LUAJ2v2enHJ8CRyCZf7oW1AC4eiMtwcsgI/S0mBlUngUx4Wo4zjo?=
 =?us-ascii?Q?yLSmvcsFHjSr/wLJ/SANWToKPzqI2sdgLMt4hBVk11KVYEH4P6OzfARF5K5q?=
 =?us-ascii?Q?yLCRn9zun0+f5QYuFR3uDiaR19yAKEglJZJeOZaWqxyClqz+3r1hcs+UsZn+?=
 =?us-ascii?Q?oKB4ZiJcJyaruZwcGSZ7onWXqYAuxHBkIXd0BSUb/MqjCKG0M9GPT8qCx21I?=
 =?us-ascii?Q?YT3KdVmt63w+SDhaH+gZ1JrVoW61w6Ttrn8n1W8xJHVFh45TE6dg2NXSk7fZ?=
 =?us-ascii?Q?ViLqoWYrFWX/h90tPxT7CIei/YlMs+6ET9R4qRit8/88/n6VpEhboihpLYO5?=
 =?us-ascii?Q?oy61aPmlSPBHXOe+H61g3uhKVfLGTz1XGeRihbWclaTgzDEAXrfHAK1Egffg?=
 =?us-ascii?Q?XJvAHmaClc5RXrqc+2bnFVmNA2phUXGKo0a/XohZzcOtXnHNYXi8tCWt3b4Q?=
 =?us-ascii?Q?LPIPfS+QDgj+BQ7sYvG/SzvNf7YZMWPGSFqaRmWqbDib5VzmcLHlKhHoMbeo?=
 =?us-ascii?Q?/Oodtz3K524bO/fZhROXTTJYDkUE+Z8qtLDbpeXAsKX2lnfkNn1llft0A6cO?=
 =?us-ascii?Q?124viqDZZUtoyfdMof/oWdMyvsDFrHcd4krpocAoJBpWuK+9Bv3HbVDMclhp?=
 =?us-ascii?Q?olDNRRzfd6u7MY2HY6mHzGNcB3x/4fN138cUJk5bS06YqlgHB6m1L/gHIMoo?=
 =?us-ascii?Q?DHDQqhu8U1Nr5eXIfdggdCmfyHqhOuu7fPdWbtsKnbKmm8qi0umhwjFFkYTe?=
 =?us-ascii?Q?GNqu3nYo6HazaIVIrf96MBoEBdiyS90nl4bmah7Nh5Y1+qvIF7JgNvChKrBj?=
 =?us-ascii?Q?9epDQ3f1gGhm7uxuZk+3+WvB8MfDSUdE8qoktmY1e0Cs0ZQI5ulVmhJIMTll?=
 =?us-ascii?Q?yVGKXMyEoyp6HVeUaw2noIe5fAK7PMxe+ll8JWCWhOnAeMNZhSAJ7UGFw8IH?=
 =?us-ascii?Q?xpJtfTVxHWo5kJzxk7wVsm6Xe0T+Cxj4fpeRKz+i/hI9jIuE9VwWv4vnIRAG?=
 =?us-ascii?Q?kyePPJu+rY7EOqCDLuW4NAzM89oFI5oaz7krR5EwbKTRLsU5s7IvcEfrKrwn?=
 =?us-ascii?Q?dTyJr3JXUhfeqfVgYCaX2W85l0eF1u8g1q8i01b2BBfqX/PiWDoG5ujjx+Is?=
 =?us-ascii?Q?rciyvH66XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 02eabc5a-f736-46af-e52f-08deb9c1896f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 18:23:21.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF05g+30n3Y7Do0bRqhUma34JZnmihMIVQ2kQu6c+b3mfwm71+rS0wjMCXVYBGKgI8wtViPBi1DPaxMkDD+5hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7560
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 18:23:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4034

Hello,

Could you also pick following patch to both master-next and wrynose-next?
May 5 - https://lists.yoctoproject.org/g/yocto-patches/message/3915 - [meta=
-security][PATCH] tpm2-pkcs11: upgrade 1.9.1 -> 1.9.2

Peter

-----Original Message-----
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> On Behalf Of Scott Murray via lists.yoctoproject.org
Sent: Sunday, May 24, 2026 2:15 PM
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-patches] [meta-security][PATCH 00/13] Assorted updates 05/2=
4

My apologies for the delay in getting this out, this patch series rolls
up the contributed patches from the past few weeks.  These changes are
queued on the master-next branch if you would like to check them out to
test yourself.  I intend to merge these to master branch Tuesday evening
(CEST, May 26) unless there are objections.

Note that there is one known issue with latest meta-oe that has blocked
getting clean CI runs that likely will impact anyone using the dm-verity
bbclass.  The root cause seems to be a new packaging conflict between
lvm2 and libdevmapper after the recent upgrade in meta-oe, but I have not
had time to try to dig into it and come up with a clean fix.  I plan to
look at that if time permits while I am at Embedded Recipes this coming
week.

Scott


Changes:

Anton Antonov (2):
  parsec-service: Update Parsec service version.
  meta-parsec: Do not run Parsec CI jobs on 32bit platforms.

Bin Cao (1):
  samhain: upgrade 4.5.2 -> 4.5.3

Li Zhou (3):
  firejail: fix COMPATIBLE_MACHINE setting
  layer.conf: correct WARN_QA
  aide-base.bbclass: correct STAGING_AIDE_DIR

Peter Marko (1):
  tpm2-tools: make efivar optional

Ross Burton (3):
  parsec-service: assign PACKAGECONFIG in one line
  parsec-service: do group membership modifications in useradd
  parsec-service: update TS group name

Yi Zhao (1):
  arpwatch: fix typos

jason.lau (2):
  google-authenticator-libpam: update 1.0.9 -> 1.11
  aide: fix pkg_postinst_ontarget shell script

 .gitlab-ci.yml                                |  12 -
 classes/aide-base.bbclass                     |   2 +-
 kas/qemuarm-parsec.yml                        |   6 -
 kas/qemux86-parsec.yml                        |   6 -
 ...Fix-unnecessary-qualifications-error.patch |  50 -
 .../parsec-service/parsec-service-crates.inc  | 868 ++++++++++--------
 ...rvice_1.4.1.bb =3D> parsec-service_1.5.0.bb} |  30 +-
 meta-tpm/conf/layer.conf                      |   2 +-
 .../recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb |   5 +-
 recipes-ids/aide/aide_0.19.3.bb               |   4 +-
 recipes-ids/samhain/samhain.inc               |   4 +-
 recipes-scanners/arpwatch/arpwatch_3.3.bb     |   8 +-
 recipes-security/Firejail/firejail_0.9.72.bb  |   5 +-
 ...bb =3D> google-authenticator-libpam_1.11.bb} |   4 +-
 14 files changed, 533 insertions(+), 473 deletions(-)
 delete mode 100644 kas/qemuarm-parsec.yml
 delete mode 100644 kas/qemux86-parsec.yml
 delete mode 100644 meta-parsec/recipes-parsec/parsec-service/files/0002-Fi=
x-unnecessary-qualifications-error.patch
 rename meta-parsec/recipes-parsec/parsec-service/{parsec-service_1.4.1.bb =
=3D> parsec-service_1.5.0.bb} (78%)
 rename recipes-security/google-authenticator-libpam/{google-authenticator-=
libpam_1.09.bb =3D> google-authenticator-libpam_1.11.bb} (85%)

--=20
2.53.0



-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#4006): https://lists.yoctoproject.org/g/yocto-patches/m=
essage/4006
Mute This Topic: https://lists.yoctoproject.org/mt/119465712/4454441
Group Owner: yocto-patches+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13703729/=
4454441/683413657/xyzzy [peter.marko@siemens.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



