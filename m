Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB95E77188
	for <webhook@archiver.kernel.org>; Sun, 22 Dec 2024 07:37:25 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.113])
 by mx.groups.io with SMTP id smtpd.web11.21011.1734853035308444498
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 21 Dec 2024 23:37:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=aBv37l0g;
 spf=pass (domain: navimatix.de, ip: 40.107.241.113, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLYsDXs+AOny7IOKy45bJdeYRiFDB4Q1LcAjAW2BZ35HGRN3o5P8Tx6oOBpaQaL2VyZZ0nq7E3fBW67NMQ51cSqr7uyC+Wk8MvWiJf8SkHDGurjCHJ6B57FmHxVBnVhKpu9hfK0SB7W3fwBul46hTGdE/NFyZQWRSI7Nn+CTrFI6gsL1veA/eSTJeI/g7hCSGzFDIW/ge4xVEKVwNOOqTLFdQvekJ5ANbJZonRQC1+c+bSNbmNmLvNoYwo3RLT1GBj0SPLjUBfXbXlzZnEv4TCw2WgN2/r6X9ok0jbttRtG4QcCmEDyj/28qgL8r3KalGanDbtlsESE7ZcXwnUr59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5/o1e0LPSoy5x0CGFTjczDzOyeyGhAoXJvlMwmBeCQ=;
 b=m/qJ+0AZ1nedoufvMElcatYZr8pa2q89elGjgAn/pwrG9VS3f1riGglVO8TFxzQDV5na1Q0dz61I5RAUhce5QbeGdKN5aW1EnJhHdj10EDoYTx1t84vYfNps1etetA6VJCfzOicWaeSe0oIVkHwxL357Epf9SYaJxWi7Slk+zSaL7n8ZhqmFHXsbwI925qI0k5YBPMnNDcpUR1b2wi2qee2jYYkZn2WteA9Jo/47nfDG/TpYIT8xWi9m9MiIiSzKgsy+Oce7QWomJyJ8jebmtym14OsNivedPY90c47ALJ9jmhXxvQpVCdXL2h+lpQsKb0bMs63sPkrGD1QRxCwJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5/o1e0LPSoy5x0CGFTjczDzOyeyGhAoXJvlMwmBeCQ=;
 b=aBv37l0g+Bkwq/537+Ac7uHYjdRiU4gIp+xjRtu0ZmXMQCkLM3Gc0fZAP7/rsiwJukh3jxeXseh/0HEhFCGxTIOqrRTtXqRydMRVe9aQ2Fbtbebamt6X1iY4tUmcI1QiTx/4oCrwumbT5XRMEZMYa4jm1wmFVjz4FwDT2yPlmSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5) by PA4PR01MB7853.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:c0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.19; Sun, 22 Dec
 2024 07:37:08 +0000
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7]) by DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7%6]) with mapi id 15.20.8272.013; Sun, 22 Dec 2024
 07:37:07 +0000
Date: Sun, 22 Dec 2024 08:37:05 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org
CC: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: Re: [yocto-patches] [meta-security][PATCH 12/18] systemd: enable TPM
 support
Message-ID: <cdqveqfiivyicrtsjzbnlxopvohsbxuybabhwdntygisoc4pz2@tnbgemicyfef>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
 <20241220140441.271395-13-mikko.rapeli@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241220140441.271395-13-mikko.rapeli@linaro.org>
X-ClientProxiedBy: BE1P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::10) To DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR01MB8293:EE_|PA4PR01MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac62c82-20b2-4707-53c7-08dd225b7051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pG8pJX0+IzvSV/qAyeRxmaEBjoxVq9W/ErVL3kNxrnpqXWQVxP4uyZo/dA3k?=
 =?us-ascii?Q?TnInyjOZCnmFfb6fR4SKVaR/ogy5J8idFwIVwb29tZqXQMNEoNM3C0nNuHLR?=
 =?us-ascii?Q?k725q9a8xBmW+qwC04RFJ/6Mf7MCOSJSSi+xbCCPwqlDEB2Hnf8tQbb6hikq?=
 =?us-ascii?Q?+vId1XmFuVbLaqAz5TopwvCDkM63+lALgQ+vHoWLvYur2CuDTH1aCKGYImBl?=
 =?us-ascii?Q?v2XSKRK3U2ro18+RKsoCTu+uUOMidbgoUMs0mhbfhFEez8ZcUmH06/YdBAIO?=
 =?us-ascii?Q?cduRVqXdbiTJI1UQOpD7DRNIjsNLl2p99iOCa5dfw5c0lkQ7EznwWyLAVU05?=
 =?us-ascii?Q?VQo4rb7km1wLLZzKiavtmvTXULP4m1j/EOivcMl86uTuqal6H1QiUbQMpky+?=
 =?us-ascii?Q?/NQtpl5926pOjNpz10QEUnCOVb7t6u2fzhAkCoravIqIk5nnM1T442yKfdJs?=
 =?us-ascii?Q?P/upr8bw4wOQzsuAp+uj5arLA5awvS1MbX0VA83QRjMBsFki1JusHpcRaOoo?=
 =?us-ascii?Q?CM83llcarkguChAJ4gLzqcSfcuPoXAbXUF9BlOgEG4iIuwhcSamJcSZvYVYC?=
 =?us-ascii?Q?Y+kM1oojg/ZuZtBYx8gHKcr5EgzuyvprlPkm6a8v0VHLLYjvj7xglA9+NYo4?=
 =?us-ascii?Q?eNMr+Mya7XMzSKoMkUXUNV6pEq1NQoTftb8DK4WQLDUcdAanF0ZwAIxhVaJ1?=
 =?us-ascii?Q?wGF/W/88h/WbstSYupDmWA9K9sIqoh1pQMQZ642kCtPMIPvRzZg1AlsOGeMm?=
 =?us-ascii?Q?/Ed9ZbX9dSULfrkBysbWY9e9ciBI6PoURcVeRwcUDe7SEE2dWao3c74pUas3?=
 =?us-ascii?Q?rXUJoLHpAfA+joovgU96OjZo4TGVz2kbjWgeCkBntP8DHmXTo2oAw6b0tE5n?=
 =?us-ascii?Q?U2KZKmxRhvYw5YzpGAG/lH8KO1WHAJelgw3rnhY41b2V6Ksv0y+A731k9dQw?=
 =?us-ascii?Q?yMC1xuZny/k7l4d4+6Jc8LHM3cZxmEwOL7Sz0ufQZvfe1Gfk/+69H1dcXseo?=
 =?us-ascii?Q?N99+CAIN0hHSKDAFfzfBdqdpEpPu3oUtfKK3+RvhlNZZvfOXi2vHidTN+a3f?=
 =?us-ascii?Q?t3ZSjwDxA006J9yU143gVIWU0aG0KKF5rCo2Ri5gyC/LCygoXvdnG6oC1OKt?=
 =?us-ascii?Q?W4R2HZGA7rTIYWnp69sONV51r1SCPXIxnxQca7tirQDfDgCHPDLzOPz82Hfs?=
 =?us-ascii?Q?f9ogPKufzVcmQZholPu7teqxNOCaGlcGQy+WI+zWhToZfE21HzJT11gwxuxm?=
 =?us-ascii?Q?m8g98HuojYnGdWmjDXT/JDLWOgYQkO+rMZe8PD8g1o8BQRlq6f3HtOpWEuWq?=
 =?us-ascii?Q?Oxs16raYp14gQDbS5fuPw6GlUsAwa0w4tXRBJTZtAEhVog=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8293.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?brV/1SyIPDBzJquSkuKfzwlP4kKsAXyfcZC6RPEgBAAaMKk8t9eiMCkMr1FM?=
 =?us-ascii?Q?wJmY5f3KY8+U1e8jQpUhDtjrTYMPKpodF7tOsnLPYSRd73iND2yT9m8zxCRc?=
 =?us-ascii?Q?Sf0sZv+V6Ui7OfV3tiqDxW3ixb8azuRmfF2UNq+LHkTNwvf+Y57Y1usSHgfl?=
 =?us-ascii?Q?T8XaQSZU8UdjNTU4MbvZB63DcRRlKfTzsls4hOrOQdOf3RuaEadrDNRxsC+L?=
 =?us-ascii?Q?10nUvCb82BkoN4FkKPzumOUhSjde9bpGoh8Pys6i+iLUZ6xP4b3cfQj/aCIY?=
 =?us-ascii?Q?lzLbmrCITtZELyP/RAN3T8VJd8mfqLUzGMJiaEepmffW9M7OUnTbbPK0K0ti?=
 =?us-ascii?Q?JGeKLNs3ZNaW/sRaYb12xuqla3MmgVMhvUnoQyeClTXpnX3fB2kSwopULszl?=
 =?us-ascii?Q?ZnF+F2dcMMVcsc4nX/pj4X+MCwUT9xUtqfp5S0I9zbWMPpMkxvQvX0CdzM56?=
 =?us-ascii?Q?ONpYBPxCJStTixbBoQ8PXOov2zBNkQRDmmEVkKCOXu8h09G4wDR7hbyyU6uN?=
 =?us-ascii?Q?wcL+d4AYwrJyAswNSTb2FkGjBQML/1SQRWYVxmymsplDzItA5bNhTOHYfV78?=
 =?us-ascii?Q?uET3B2QhOq5PqRUJsZy9XP+et26S1IC0uY41fgbafOPCcLwKyaPUYeHMMgFc?=
 =?us-ascii?Q?q3kJdm5o3yV4XpRXsyLOd1SuyAvNbkmUn8FoNrQSeCb67CWlV9CN0bpTApPn?=
 =?us-ascii?Q?p8qke1YCQ306V2uEdmGfE29jbQwxm2VAFaRCz5auuJN5DJAbOlu7Top7AzOa?=
 =?us-ascii?Q?Mqzbkz84Gk+uUhZDIyGUTzwAFJHn+Vzx7SgTUzl5BXTSKC1loAOcGRndAnKE?=
 =?us-ascii?Q?4qJl0nJsrDOrzlP9URftiUDj/No8DnHRYUDJnvtRS8948lMhLB7+O2fRf7sE?=
 =?us-ascii?Q?YfizSLy+nU4qXFcSCMfQUfHBdN9indKl2fjtatUJwj4covs2nWaIixt5l1uf?=
 =?us-ascii?Q?FLK5BPU6E+lwuPNaNUdHBmhGx6uCLEVlJ5A/Qi8jxscW1uHgk03aeQYkX0bI?=
 =?us-ascii?Q?oV8/PCBfsoR0ZeJD8Mg62n68vw+N2l5VodjXYYryWLTDjfvb6LWJw2T4jKtA?=
 =?us-ascii?Q?JJbrezK4l2bw4AXlwUnjwztNmDg0BUqUNnLHSIAhbubPT3znON/Bo2XMb0GS?=
 =?us-ascii?Q?hxeYYjAMm0vQihfsdYZswcI+JgtyuRXU00v5SKZfPOHN7cA+9oYm8VF8aiCm?=
 =?us-ascii?Q?Porqz09Nr4tKsUreb1oBrem7tlJVj2BL2J36LCHWSapJ0sjcEtFKZTwtsnif?=
 =?us-ascii?Q?dNX2zooZOXB+s6C6V1/cbS0eg4ZPFV8ZI/DvuQgBg1l/wUDCq9rZSkbs42pj?=
 =?us-ascii?Q?0okoz86gDBjSy7yiF3g5Hb3BbAKYCp/RnNAE+si8uWrlpmAWT1XaiZbRilDK?=
 =?us-ascii?Q?yaMNahv7iGTf3PRn1N6jC9Y7MEdUN9Il+1fXJiRoFInPY/HfFJ74h/lQX1rD?=
 =?us-ascii?Q?6igYDMuduwvPeRihC0Ir41gZ307y6ueoF9CVCjZP1MdxuRDokCZZXZdpxmUA?=
 =?us-ascii?Q?JW6Se3Tyaz7nxsKFRlzPFsdADx4Z4Rzky2JjxduY3kdfWYyA2HPgPXWvnlaj?=
 =?us-ascii?Q?5xsJxeJlAdAj8n0CxlFMcQX3VQvGRrQmyySJN19Ttu5Dd8DiCLIbqWQSK83j?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac62c82-20b2-4707-53c7-08dd225b7051
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8293.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2024 07:37:07.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRwg+ozbLk39CxmVdGRuV3BucTJHP5JfCOCThnqaWu3m4PCi2+C8LhEOcKwHZrmNc9cz+k8LE/MIVRv9AUYX/u6gup6bqTL0X/i1LCIZkmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR01MB7853
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 22 Dec 2024 07:37:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/958

Mikko Rapeli via lists.yoctoproject.org schrieb am Fr 20. Dez, 16:04 (+0200=
):
> Enable "tpm2" support if "tpm2" is in DISTRO_FEATURES.
> Also enable cryptsetup, openssl and repart features which
> are needed to use TPM device to encrypt filesystems with
> systemd configuration. See:
>=20
> https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.ht=
ml#--tpm2-device=3D
>=20
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  .../recipes-core/systemd/systemd_%.bbappend     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 meta-tpm/recipes-core/systemd/systemd_%.bbappend
>=20
> diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/=
recipes-core/systemd/systemd_%.bbappend
> new file mode 100644
> index 0000000..82b79ba
> --- /dev/null
> +++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> @@ -0,0 +1,17 @@
> +PACKAGECONFIG:append =3D " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2=
', 'tpm2', '', d)}"

How about using `bb.utils.filter('DISTRO_FEATURES', 'tmp2', d)` here?


Regards, J=F6rg

--=20
=BBAuch die Apokalyptiker glauben ja an eine einwandfrei absehbare Zukunft,=
 die
keinen Zickzackkurs kennt und keine Ungleichzeitigkeit zul=E4sst. Ihr Pessi=
mismus
ist ebenso gradlinig und fantasielos wie der Optimismus, der die Fraktion d=
es
unaufhaltsamen Fortschritts auszeichnet.=AB      (Hans Magnus Enzensberger)

