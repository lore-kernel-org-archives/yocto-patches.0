Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DCCA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 03:51:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.web11.67056.1755489103150717288
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 20:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=W6AnzrDf;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755489103; x=1787025103;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=NhyQ6bFeILk8oVxfC+941Dd1baD69uIsJH6dKehEoJc=;
  b=W6AnzrDfeHyzdIpvkL902wF+Gg+8rpTGTzu9L3/dpkNrxv4xnAqXwRVs
   3VmDD/C285n9PiKzSXhC1iOdyRJZaVnqVaALz7srPwgCFlguqADhWA9Jv
   zwMF24WpiaTOwOWWZDUrPyTuWoJADErt6gyM/Yus6Iki65zkLQ6iigHrr
   ydAZp4cgk4FsFoNbSLqN1XOc//TEJFerVR9tJQUjOThV/gPqBsAmnY9Kp
   C/xBFVn3trL5rLZQ/nDHewwLFlptgtGpIpVsv6F7FwAHlfn/+BVzBCpIy
   NsN2NBnPAqWlU8C54f4PF0X+/jJMkOK+q/W1gdJvO0WFzuNBfAlZ0NgYI
   Q==;
X-CSE-ConnectionGUID: 10Wt12shTbCOG2Wri+dS4A==
X-CSE-MsgGUID: og0nndvSRrqAMCD6lmU3xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68795534"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68795534"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 20:51:42 -0700
X-CSE-ConnectionGUID: EevOeBruS4Cuiz/zmDa3Gg==
X-CSE-MsgGUID: gx3/F4nsTr+r63UOUD5OXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167083105"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 20:51:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 20:51:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 20:51:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.74)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 20:51:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwvGx3xQ1cYHbMbo9hrSKLyJY7pE/uh93E6qVc7cGnqXVO5+YFwAbPL+lwkCwacLYZaMto0lO+GE8XviniEU8MwNTL9ybTce0ZQLOTkfoJyH1CKJwYBNOaZ+BHKjxatbZgdnL3NB5oq0ircAaSTqXFFg89lNII9RLQRjWtQ+edD7QMZoAYnOI2r872tR96A357mz96WcudA70FqOuC1LU7ezf0pxht2feKs1UvX/4xHZRgjTuE7KwROwL4511XM8jOgzcQEOcFvBs1PgQqXSBs5i6gPdlE1CpjiKzn1stAzD9DfsREwn21aX8XzxYx8px/HqaRqxMxzjC0ub6wMMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhyQ6bFeILk8oVxfC+941Dd1baD69uIsJH6dKehEoJc=;
 b=IlxDDkzl5KpB9poq+F2SBoZJW2p4Uy4jMSqKY3gYTZ98NLJbh36ATz7lZ2vlXGoFAhTu8eEbHjsJiyuy71fcFKEokEYtWeR8xEnpLmGOkkcegYzaB0f2TKB95boKnLysrrZsA10fpXTPOPlD9PoSXB8O5OIe7Oqe8LtDtkJ7fuDOExgjyLGf7DxRoKCAK2z65WqpahYQfBx+6dLQMdaj0F81+HMsw37XId6Ps+7OpIJCiUzozqJV55MhYvGthNZQHilrEY8Tv7nV7W91za2qU40DfCNMW2RV6vzxFT0hGYIKYD/2/cqD3ZQOnuR7YOEg+UppCkmjsSjXEM0buabKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by SA1PR11MB6968.namprd11.prod.outlook.com (2603:10b6:806:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 03:51:38 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 03:51:38 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Topic: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Index: AQHcC7Bu/DmjA0VRkEG7stLVdXF6erRf5uyggAFv1oCAAz3XAIADANtA
Date: Mon, 18 Aug 2025 03:51:38 +0000
Message-ID: <BL4PR11MB879701F9E70B3BBA7A74EFCCB931A@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
 <SN7PR12MB8770AEA28E0566FB714AE8CDDA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
 <2fe12dc4-be39-4ade-816d-fed337a65fcd@amd.com>
In-Reply-To: <2fe12dc4-be39-4ade-816d-fed337a65fcd@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|SA1PR11MB6968:EE_
x-ms-office365-filtering-correlation-id: 7df42326-79d2-48a7-0433-08ddde0a890c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d09Xd2ZIQTdxSVM4RnlVQjlkaXczMU8wUjY4WG5TeURlc2FmQkRmaFVKTU9u?=
 =?utf-8?B?cnVhSXVEaE1XanlqZURXRlBLNmxEOVJMSndZTFRMeGF1VXNxRm1zcmd1U2xS?=
 =?utf-8?B?NnNoc0JFT1BxWUFKdCtMdGpEb2QzZFRzMTlXYzA4V21zUWNhYUlGQ0YvdTNX?=
 =?utf-8?B?YVd6RVlxZjZxRG4zRDBEb0pIek1kRVlBSHBBemR5d1hPanNRM21aS2FLRGto?=
 =?utf-8?B?MFRRRWJvczZwMWlDZXlQdVNjcmRQeUdCZmJvT2NKWVZIY3ZCZkFvRk1QWkxn?=
 =?utf-8?B?blZLRjRraVk0alZTS3pxeTFaQ2o3TVBrTitNWExwSEN0OGF5REFEa3BTWGdR?=
 =?utf-8?B?azVWTkk1MUJ1eVJkSElRUjJvbkt1UGI0MXhwODNiK2tWVzlRRzlTOS9sZFlO?=
 =?utf-8?B?OHZjVXA2V1ZWTExWNFVUQysvSXZxNXRWdktuUys2RFVyTGlTUmhOZncvMWl3?=
 =?utf-8?B?T0h6d1hJR2pyamxkYjQvSk1ISGpPcmE4anNIVm5vZTRNSml3Ty9uQUdLRk9S?=
 =?utf-8?B?R1ZVRDV6OXdJRHV3N2dNM3M2Zk9PdEJsakVnaUxVeldRZWZ3MHFCWDRpU1hv?=
 =?utf-8?B?L2ZFVjlITGZrQUdLZXpSN002cXBhSGhMTjUzNUJRQUt0Ym1TYXlQZGNwUk1E?=
 =?utf-8?B?anNMK1c4SVZxTlZsYnpvODhvbG56czB4NVAxQTIxRDlHaEQ3WldFcnhvWXF4?=
 =?utf-8?B?Nm16VW1wMWZBRC9VUll2eWExZnZ0VW9xYnFRTDFqUmZXNzVCdzY5SWRrVXE3?=
 =?utf-8?B?NnFZN3N6Vm42aEFpd3Vuai8zZWdocW1McWhvRENxbU9PWjBEMCt3ZUxtUXVD?=
 =?utf-8?B?MFNlOUEvaXBvSHAxNUEvaExwOG0rUGk4ZHdnaStwS2ZiZjJaVWtJRFFmMFJL?=
 =?utf-8?B?UnN3c2FwMVNNMDZKcHgvVWxXcjRQS055eDRzeU1qOGJpamlpaWluTXlrVHFq?=
 =?utf-8?B?UGZnME1FRWlqbHh2TlRuMFNtc1ZMMWVUckFCTUQ5Wjh4Z1Q2WlM5bkFJRE4v?=
 =?utf-8?B?Skl5TXNHQ0dWemJNd29aVjZ0SXBlcGV2Qm84M1lSMTFRVzZyNDRxOGxUaUh0?=
 =?utf-8?B?N3lUdWR6SGZzUHZEWUdKZE8wdmJ3WHJTSkRoR2hmbW15M0N6dzMvNTZuekVj?=
 =?utf-8?B?Mm4xTkFabHQ2K3l6K05NYU1QNUZYUWhuN2FVZHFVNUtSeGtqY1dMbXFURHVG?=
 =?utf-8?B?Skc1M2NKL0hjSE5tL2xZaHZWMFJjTE44bnoyUFlKZ28wN2VyaVJ3aGdMTnlM?=
 =?utf-8?B?SklFMXNjcEF6N3FWbzRqWXVFc1FVNkE0U1BwaGFlRUszWlJDUndYTy92dU1p?=
 =?utf-8?B?VDFCdmRZZ0U1SkIxeU9qK25FaXdZQTN0MVpNaFlNZTVPSWRNQ1VEcFlXRHFU?=
 =?utf-8?B?TmtYcStrbk5xM3c1LytMcXcrcFJkcWplZTNldFFkN05hU1lDSzZoeFByUVRG?=
 =?utf-8?B?U3JqMHZLMFFwWlMvN2ZUVFNObWI2d3RsV1pNTkhMbXg4ODRrbE1yRmpvajVx?=
 =?utf-8?B?bnVkdXlyY2s1UHowS20zdHhpUHdMUk1YV1p4VkNnZ3R3WmFzc0pJMysyZENP?=
 =?utf-8?B?MmlVRWpHYzdEZWwxRDZ0WUV6L3JIbElKQk1ZWGkva01rVmdjZ2NDZ0dKZmhm?=
 =?utf-8?B?MXQ0dys2V0gwNmwrZnhRM0o1NmVFUjNFdjdjb20weEgvR0xLQjY3dTY2TUpB?=
 =?utf-8?B?bERiL0g2cExpVUwrT3hpRnYvdTExaEpqTzdlMDNMdGxuRDdCYlZqOGo0UzJK?=
 =?utf-8?B?a2tkbno3bzB5Rk1OeVRBVHZDcVJCUGJ1ckh5UThmUUVwS1hSR1JmakMvcXU0?=
 =?utf-8?B?c1Bzb1dQS0VyM3padEpuRU4rTXFWb1gzRW5wN0JLL1dPeW9DREtxa1BjYTJq?=
 =?utf-8?B?bnJzZVBIRFVRUk9PV203ZWI3bEF4U0dnYmlycmdUNUIrZ2Zja3BiaGFSS3Nn?=
 =?utf-8?Q?E/hvgF6fI4o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkRCWllSa2orVHYyR0E1NzVkNDNuNjAzWG52VU9xZGNXeFJidStwQzdjWkZY?=
 =?utf-8?B?c0xqNnBhN0ZFNTFYUEtaaGpYb3FUKzJnRlhMbXpCUVhJYWFQTnVYWnNMWHFI?=
 =?utf-8?B?Y1VaeHp1MUJickNGWkxPN1UzMFFIVzhyb1ZDZjBOdXVvSHRSRHBqRGE2QXFs?=
 =?utf-8?B?R0pNd1NmS2lRSENoWk0zdjF4WmxrdmFYaHo1bmF6NzFhUUpnS3IyZ0FmT2F3?=
 =?utf-8?B?MHo2TDhMcnZrY0VENzNRclR0MFBmdWhRWmdoYi9QMG43RTBTVmt2Tm82OXpO?=
 =?utf-8?B?Mnl1d1kvMGNieFYyNmdDS1lGanNyVExZdXNCTFFVZzJaWDlOdmN5ZG9pdGRn?=
 =?utf-8?B?cHRkWkN2Qkhkdit3N1RicTlsaWZ4Ty9BaldNd2JtZTMrNklralFIRDQrbzkw?=
 =?utf-8?B?Y1VNNDRKYTRDaWd3MXl3NVBQdStXK1kyUzFkZWJRQUlzNit0NXpFenpzTUFF?=
 =?utf-8?B?ZzdaMG5NelZmSjZ1VHNqUEM0Nnk4TnVvS0Yrd082S21yUXluQ2dPc0JXTWhV?=
 =?utf-8?B?QWsxYy9zZm8yV1hweGJIeU1QckdoQ2RHSjZET3N0QWZmWnRueEMvSW1PcEhC?=
 =?utf-8?B?VGFlM1Z0VzNza0dHWHl3bWJ6dHY1VjdDbmdsNzdvNkl2NjdYT1lPeXBlZEhh?=
 =?utf-8?B?UE9QeExsRVduNnU1M3FkL1ZtUkRFV2wrQ2pWaWl0SHpJeFFEMExEVVZtemtX?=
 =?utf-8?B?Nkpob3NzUjVaR3hyNU5qRkNYNmdGTUd0TjBYb0d5aGxheWl1TFdVWUNBSThr?=
 =?utf-8?B?OGFIbkpQZEIzTnRkelJOMS9WZmc4UkIrSWFaNjh2U29SN3VMWGNqeG9uMFdO?=
 =?utf-8?B?a040QUpzMjNTSUZyVzI1MGwzWHZGTHBSVnVMTmNuK0ZKU1JSRDcxRzRkNjFx?=
 =?utf-8?B?Vm9uRGllZGhWTGMxai9YVng1bEozYU50dXhjdUZIWU9xUVBxSEpQeFdmdW5M?=
 =?utf-8?B?RFE3SGdQWERuOVpNMFBVbVZCblV2cVdrdmVrd082dmpSZm1qcXJJWGxYcFJ1?=
 =?utf-8?B?QW9SR1ppM2Mrc2ZwaE5EVjlCNUUvc0s5ZEo3QngyT29tS1ZmWmg4ZmozRXJl?=
 =?utf-8?B?N2VFSVVrbnl6MFhMcEoyQUJscXFhWWEzM3BJWC85cjZ0ZjByYlNLMkZPSmMv?=
 =?utf-8?B?YmlRQlo2eURPWTR1dzRnS3VGUXFWa05jbnhaN1h6MzFrUkp6ZnJlVHdPWGpp?=
 =?utf-8?B?VEJzcFI5TEtxd096V056WGtsLzIwb0NWNGYxM3poZk1oelZ5d3hLdUVvendy?=
 =?utf-8?B?TEFXYzVWSVBIYkEzQjMreHUvc3FOdGJ1Q2wzOXJXYkt5Vnljdms1TWpkc1N3?=
 =?utf-8?B?OWhCejdYR25MSW1ZY1JSMS82a2czTXFKQ2Z6SGQxOXpIdUgwaGFTSlcrWmpa?=
 =?utf-8?B?aC93NHJaWDRiZ3UzVUoxVmkzeGhiMkVjZUY5Mm9rdTV4eE5vdHYxWmhUMjBp?=
 =?utf-8?B?b2wraDFwNXdIRENpWWozMWlpUTRmUnBndi9UeTNudW1aK25QcnFWaVlaUlZa?=
 =?utf-8?B?aWw4bXpWeU1OUFl5Y1gxcG5hdlNCWVA3eS9UVTV2NGY1NDNoaGVqdDFUZWs2?=
 =?utf-8?B?d3g4RzJ5SnpQMEhsUzRWZU0yZFJJZmFBaTB4RXFVZ3RWakpPM1ZxUzNLVE0w?=
 =?utf-8?B?M1piQ0dpMEZzdWg0cVJRT1U4TzRIa1FIbnhnQUdTMFFlakMvR2JKbEZnWXVN?=
 =?utf-8?B?SnBkL0xBaTFNaWtEWm16V3huanZ4NUxtYTVYaXJSeVVRMnhEazRTS1VVQzdz?=
 =?utf-8?B?RzJlVVVKMGtBRDM4NVg5eEF4eHVubUhXMGVTcFdDbkJTZHRrcmRWa0hCQlNh?=
 =?utf-8?B?eWpCYVR0S0xaUkhGUk1CdnBzTElsb0hTd093ZDFRTGU3cnlpclpnY0dNazFm?=
 =?utf-8?B?cXlQMS9RTGtmQXkyeUlSV3d5cHUrdVQ3bDRFY3VSRFZ2RXlobDNOZkhDdkNZ?=
 =?utf-8?B?N0ZXaGdmeTYyNlFpT1NYazlOVTYxN1BXZ0Z1a3FXZ2gyR3NlSEVTN0FmaXE0?=
 =?utf-8?B?MHFzNFh2UVZpUU1VSkEvWmUrRWhCZk5ubkpZUG5JempKa1RPb3Y0cWdCcXJ5?=
 =?utf-8?B?clJ2Qit4UXhGWkZzdm9zN0gxOHZWWHptUWpsYmNVclFxKzN6YXY1ZGJZZWJx?=
 =?utf-8?Q?ojoJ5CM5/H4L1fSBUOqGc9FJ8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df42326-79d2-48a7-0433-08ddde0a890c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 03:51:38.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ah47ZJreNRxsAr7zFSM9uHlAST2F4E+1MnfLMlY+SfL0c7/Ql0nd98GoJadkKXZ9tgn2LZ2pJKowgYHrqQf3lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6968
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 03:51:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2032

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VuZGx1cGV0IFJhanUs
IFNhbmRlZXAgPHNhbmRlZXAuZ3VuZGx1cGV0LXJhanVAYW1kLmNvbT4NCj4gU2VudDogU2F0dXJk
YXksIDE2IEF1Z3VzdCwgMjAyNSAxMDozMiBBTQ0KPiBUbzogeW9jdG8tcGF0Y2hlc0BsaXN0cy55
b2N0b3Byb2plY3Qub3JnOyBMZWUsIENoZWUgWWFuZw0KPiA8Y2hlZS55YW5nLmxlZUBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtemVwaHlyXVtzY2FydGhn
YXBdW1BBVENIIHY1IDQvMTJdIHplcGh5ci0NCj4gaW1hZ2U6IEFkZCBpbWFnZSBhcnRpZmFjdHMg
dG8gb3V0cHV0IGZpbGVzDQo+IA0KPiANCj4gT24gOC8xMy8yMDI1IDc6MDIgUE0sIFNhbmRlZXAg
R3VuZGx1cGV0IFJhanUgdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gd3JvdGU6DQo+ID4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cj4gPg0KPiA+IFRoYW5rcywNCj4gPiBTYW5kZWVwDQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8
eW9jdG8tDQo+ID4+IHBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9m
IExlZSBDaGVlIFlhbmcgdmlhDQo+ID4+IGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gPj4gU2Vu
dDogVHVlc2RheSwgQXVndXN0IDEyLCAyMDI1IDk6MTMgUE0NCj4gPj4gVG86IHlvY3RvLXBhdGNo
ZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW3lvY3RvLXBhdGNo
ZXNdIFttZXRhLXplcGh5cl1bc2NhcnRoZ2FwXVtQQVRDSCB2NSA0LzEyXQ0KPiA+PiB6ZXBoeXIt
DQo+ID4+IGltYWdlOiBBZGQgaW1hZ2UgYXJ0aWZhY3RzIHRvIG91dHB1dCBmaWxlcw0KPiA+Pg0K
PiA+Pg0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206
IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8eW9jdG8tDQo+ID4+PiBwYXRj
aGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IE9uIEJlaGFsZiBPZiBTYW5kZWVwIEd1bmRsdXBl
dCBSYWp1DQo+ID4+PiB2aWEgbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiA+Pj4gU2VudDogV2Vk
bmVzZGF5LCAxMyBBdWd1c3QsIDIwMjUgMTo0MiBBTQ0KPiA+Pj4gVG86IHlvY3RvLXBhdGNoZXNA
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZzsgTGVlLCBDaGVlIFlhbmcNCj4gPj4+IDxjaGVlLnlhbmcu
bGVlQGludGVsLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFt5b2N0by1wYXRjaGVzXSBbbWV0YS16ZXBo
eXJdW3NjYXJ0aGdhcF1bUEFUQ0ggdjUgNC8xMl0NCj4gPj4+IHplcGh5ci0NCj4gPj4+IGltYWdl
OiBBZGQgaW1hZ2UgYXJ0aWZhY3RzIHRvIG91dHB1dCBmaWxlcw0KPiA+Pj4NCj4gPj4+IEluaGVy
aXQgaW1hZ2UtYXJ0aWZhY3QtbmFtZXMgYmJjbGFzcyBpbiB6ZXBoeXItaW1hZ2UuaW5jIGFuZCBh
ZGQNCj4gPj4+IGltYWdlIGFydGlmYWN0cyB0byBvdXRwdXQgZ2VuZXJhdGVkIGZpbGVzLg0KPiA+
Pj4NCj4gPj4+IEJlZm9yZToNCj4gPj4+IHplcGh5ci1oZWxsb3dvcmxkLmVsZg0KPiA+Pj4NCj4g
Pj4+IEFmdGVyOg0KPiA+Pj4gemVwaHlyLWhlbGxvd29ybGQte01BQ0hJTkV9LXtEQVRFVElNRX0u
ZWxmDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2FuZGVlcCBHdW5kbHVwZXQgUmFqdSA8
c2FuZGVlcC5ndW5kbHVwZXQtDQo+ID4+IHJhanVAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
ICAuLi4vemVwaHlyLWtlcm5lbC96ZXBoeXItaW1hZ2UuaW5jICAgICAgICAgICAgfCAyOCArKysr
KysrKysrKysrKystLS0tDQo+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQNCj4gPj4+IGEvbWV0YS16
ZXBoeXItY29yZS9yZWNpcGVzLWtlcm5lbC96ZXBoeXIta2VybmVsL3plcGh5ci1pbWFnZS5pbmMN
Cj4gPj4+IGIvbWV0YS16ZXBoeXItY29yZS9yZWNpcGVzLWtlcm5lbC96ZXBoeXIta2VybmVsL3pl
cGh5ci1pbWFnZS5pbmMNCj4gPj4+IGluZGV4IGQ2ZWUyMWYuLjkzZDM2YjEgMTAwNjQ0DQo+ID4+
PiAtLS0gYS9tZXRhLXplcGh5ci1jb3JlL3JlY2lwZXMta2VybmVsL3plcGh5ci1rZXJuZWwvemVw
aHlyLWltYWdlLmluYw0KPiA+Pj4gKysrIGIvbWV0YS16ZXBoeXItY29yZS9yZWNpcGVzLWtlcm5l
bC96ZXBoeXIta2VybmVsL3plcGh5ci1pbWFnZS5pbmMNCj4gPj4+IEBAIC0xLDI5ICsxLDQ3IEBA
DQo+ID4+PiAgIHJlcXVpcmUgemVwaHlyLWtlcm5lbC1zcmMuaW5jDQo+ID4+PiAgIHJlcXVpcmUg
emVwaHlyLWtlcm5lbC1jb21tb24uaW5jDQo+ID4+PiAtaW5oZXJpdCBkZXBsb3kNCj4gPj4+ICtp
bmhlcml0IGRlcGxveSBpbWFnZS1hcnRpZmFjdC1uYW1lcw0KPiA+Pj4NCj4gPj4+ICAgT0VDTUFL
RV9TT1VSQ0VQQVRIID0gIiR7WkVQSFlSX1NSQ19ESVJ9Ig0KPiA+Pj4NCj4gPj4+ICtaRVBIWVJf
SU1BR0VfTElOS19OQU1FID89ICIke1BOfS0ke01BQ0hJTkV9Ig0KPiA+Pj4gK1pFUEhZUl9JTUFH
RV9CQVNFX05BTUUgPz0gIiR7UE59LQ0KPiA+Pj4gJHtNQUNISU5FfSR7SU1BR0VfVkVSU0lPTl9T
VUZGSVh9Ig0KPiA+Pj4gKw0KPiA+Pj4gICBkb19pbnN0YWxsKCkgew0KPiA+Pj4gICAgICAgaW5z
dGFsbCAtZCAke0R9L2Zpcm13YXJlDQo+ID4+Pg0KPiA+Pj4gLSAgICBpbnN0YWxsIC1EICR7Qn0v
emVwaHlyLyR7WkVQSFlSX01BS0VfT1VUUFVUfQ0KPiA+PiAke0R9L2Zpcm13YXJlLyR7UE59LmVs
Zg0KPiA+Pg0KPiA+PiBTaW5jZSB0aGlzIGlzIGZvciBzdGFibGUgYnJhbmNoLCBJIHRoaW5rIHdl
IHNob3VsZCBrZWVwIHRoZQ0KPiA+PiBlbGYvYmluL2VmaSBmaWxlIHdpdGggb2xkIG5hbWluZy4g
V2UgY2FuIGRlcGxveSBib3RoICR7UE59LmVsZiBhbmQNCj4gPj4gJHtaRVBIWVJfSU1BR0VfQkFT
RV9OQU1FfS5lbGYsICAke1BOfS5lbGYgY2FuIGJlIGNvcHkgb2Yvc29mdCBsaW5rIHRvDQo+ID4+
IGxhdGVzdCAgJHtaRVBIWVJfSU1BR0VfQkFTRV9OQU1FfS5lbGYsIHNhbWUgZm9yIC5iaW4gYW5k
IC5lZmkuDQo+ID4+DQo+ID4gW1NhbmRlZXBdIDogQWdyZWVkIHRoaXMgaXMgZm9yIHN0YWJsZSBi
cmFuY2ggYnV0IHRvIG1lIHRoaXMgc2VlbXMgdG8gYmUgYSBidWcuDQo+IERlcGxveWluZyAke1BO
fS5lbGYgaXMgbm90IGEgWVAgYmVzdCBwcmFjdGljZS4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IFtT
YW5kZWVwXTogQ2hlZSBZYW5nLCBwaW5nIG9uIGFib3ZlIHF1ZXN0aW9uLltdIA0KDQpUaGlzIGhh
cyBiZWVuIGRlZmF1bHQgYmVoYXZpb3VyIGZvciBsb25nIHRpbWUsIEkgdGhpbmsgc29tZSBleGlz
dGluZyBidWlsZCBtaWdodCBoYXZlIGV4cGVjdGVkIGxhdGVzdCBidWlsZCBkZXBsb3kgd2l0aCAk
e1BOfS5lbGYuIEFncmVlIHRoYXQgd2UgY2FuIGRyb3AgJHtQTn0uZWxmIGZvciBtYXN0ZXIuDQoN
Cg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gKyAgICBpbnN0YWxsIC1EICR7Qn0vemVwaHlyLyR7
WkVQSFlSX01BS0VfT1VUUFVUfQ0KPiA+Pj4gKyAke0R9L2Zpcm13YXJlLyR7WkVQSFlSX0lNQUdF
X0JBU0VfTkFNRX0uZWxmDQo+ID4+Pg0KPiA+Pj4gICAgICAgaWYgWyAtZiAke0J9L3plcGh5ci8k
e1pFUEhZUl9NQUtFX0JJTl9PVVRQVVR9IF0NCj4gPj4+ICAgICAgIHRoZW4NCj4gPj4+IC0gICAg
ICBpbnN0YWxsIC1EICR7Qn0vemVwaHlyLyR7WkVQSFlSX01BS0VfQklOX09VVFBVVH0NCj4gPj4+
ICR7RH0vZmlybXdhcmUvJHtQTn0uYmluDQo+ID4+PiArICAgICAgaW5zdGFsbCAtRCAke0J9L3pl
cGh5ci8ke1pFUEhZUl9NQUtFX0JJTl9PVVRQVVR9DQo+ID4+PiArICR7RH0vZmlybXdhcmUvJHta
RVBIWVJfSU1BR0VfQkFTRV9OQU1FfS5iaW4NCj4gPj4+ICAgICAgIGZpDQo+ID4+Pg0KPiA+Pj4g
ICAgICAgaWYgWyAtZiAke0J9L3plcGh5ci8ke1pFUEhZUl9NQUtFX0VGSV9PVVRQVVR9IF0NCj4g
Pj4+ICAgICAgIHRoZW4NCj4gPj4+IC0gICAgICBpbnN0YWxsIC1EICR7Qn0vemVwaHlyLyR7WkVQ
SFlSX01BS0VfRUZJX09VVFBVVH0NCj4gPj4+ICR7RH0vZmlybXdhcmUvJHtQTn0uZWZpDQo+ID4+
PiArICAgICAgaW5zdGFsbCAtRCAke0J9L3plcGh5ci8ke1pFUEhZUl9NQUtFX0VGSV9PVVRQVVR9
DQo+ID4+PiArICR7RH0vZmlybXdhcmUvJHtaRVBIWVJfSU1BR0VfQkFTRV9OQU1FfS5lZmkNCj4g
Pj4+ICAgICAgIGZpDQo+ID4+PiAgIH0NCj4gPj4+ICsNCj4gPj4+ICAgRklMRVM6JHtQTn0gPSAi
L2Zpcm13YXJlIg0KPiA+Pj4gICBJTlNBTkVfU0tJUCArPSAibGRmbGFncyBidWlsZHBhdGhzIg0K
PiA+Pj4gICBTWVNST09UX0RJUlMgKz0gIi9maXJtd2FyZSINCj4gPj4+DQo+ID4+PiAgIGRvX2Rl
cGxveSgpIHsNCj4gPj4+IC0gICAgY3AgJHtEfS9maXJtd2FyZS8ke1BOfS4qICR7REVQTE9ZRElS
fS8NCj4gPj4+ICsgICAgY3AgJHtCfS96ZXBoeXIvJHtaRVBIWVJfTUFLRV9PVVRQVVR9DQo+ID4+
PiAke0RFUExPWURJUn0vJHtaRVBIWVJfSU1BR0VfQkFTRV9OQU1FfS5lbGYNCj4gPj4+ICsgICAg
bG4gLXNmICR7WkVQSFlSX0lNQUdFX0JBU0VfTkFNRX0uZWxmDQo+ID4+PiArICR7REVQTE9ZRElS
fS8ke1pFUEhZUl9JTUFHRV9MSU5LX05BTUV9LmVsZg0KPiA+Pj4gKw0KPiA+Pj4gKyAgICBpZiBb
IC1mICR7Qn0vemVwaHlyLyR7WkVQSFlSX01BS0VfQklOX09VVFBVVH0gXQ0KPiA+Pj4gKyAgICB0
aGVuDQo+ID4+PiArICAgICAgIGNwICR7Qn0vemVwaHlyLyR7WkVQSFlSX01BS0VfQklOX09VVFBV
VH0NCj4gPj4+ICR7REVQTE9ZRElSfS8ke1pFUEhZUl9JTUFHRV9CQVNFX05BTUV9LmJpbg0KPiA+
Pj4gKyAgICAgICBsbiAtc2YgJHtaRVBIWVJfSU1BR0VfQkFTRV9OQU1FfS5iaW4NCj4gPj4+ICR7
REVQTE9ZRElSfS8ke1pFUEhZUl9JTUFHRV9MSU5LX05BTUV9LmJpbg0KPiA+Pj4gKyAgICBmaQ0K
PiA+Pj4gKw0KPiA+Pj4gKyAgICBpZiBbIC1mICR7Qn0vemVwaHlyLyR7WkVQSFlSX01BS0VfRUZJ
X09VVFBVVH0gXQ0KPiA+Pj4gKyAgICB0aGVuDQo+ID4+PiArICAgICAgIGNwICR7Qn0vemVwaHly
LyR7WkVQSFlSX01BS0VfRUZJX09VVFBVVH0NCj4gPj4+ICR7REVQTE9ZRElSfS8ke1pFUEhZUl9J
TUFHRV9CQVNFX05BTUV9LmVmaQ0KPiA+Pj4gKyAgICAgICBsbiAtc2YgJHtaRVBIWVJfSU1BR0Vf
QkFTRV9OQU1FfS5lZmkNCj4gPj4+ICR7REVQTE9ZRElSfS8ke1pFUEhZUl9JTUFHRV9MSU5LX05B
TUV9LmVmaQ0KPiA+Pj4gKyAgICBmaQ0KPiA+Pj4gKw0KPiA+Pj4gICB9DQo+ID4+PiAgIGFkZHRh
c2sgZGVwbG95IGFmdGVyIGRvX2luc3RhbGwNCj4gPj4+IC0tDQo+ID4+PiAyLjM0LjENCj4gPj4+
DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+
DQo+ID4NCj4gPiAtPS09LT0tPS09LT0tPS09LT0tPS09LQ0KPiA+IExpbmtzOiBZb3UgcmVjZWl2
ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KPiA+IFZpZXcvUmVwbHkgT25saW5l
ICgjMTk4Nik6DQo+ID4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0
Y2hlcy9tZXNzYWdlLzE5ODYNCj4gPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8vbGlzdHMueW9j
dG9wcm9qZWN0Lm9yZy9tdC8xMTQ2NzAxNDIvODE4ODM2OQ0KPiA+IEdyb3VwIE93bmVyOiB5b2N0
by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gPiBVbnN1YnNjcmliZToN
Cj4gPiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRjaGVzL2xlYXZl
LzE0MjExOTI3LzgxODgzNjkvDQo+ID4gNTE4MDQ4MTE2L3h5enp5IFtzYW50cmFqdUBhbWQuY29t
XQ0KPiA+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+ID4NCj4gPg0K

