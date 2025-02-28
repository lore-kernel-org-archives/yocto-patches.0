Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D29C282C5
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 09:34:07 +0000 (UTC)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mx.groups.io with SMTP id smtpd.web11.8502.1740715517202146190
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Feb 2025 20:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=EtfKQGYa;
 spf=pass (domain: cisco.com, ip: 173.37.142.90, mailfrom: madmarri@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8804; q=dns/txt;
  s=iport01; t=1740715517; x=1741925117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=4iH/fgQKvwHt0nctdee8ksPG+vAq0gp+a0Vhh2/3Qs4=;
  b=EtfKQGYa7NhqZjVTR1MK5ClWMj8C0HFXG1I8otreIVrsDopwvE8/deNj
   W4QcSaUFfUYI1/taQLuhaeC83nEMeBg1qWDVg+34NDA02n6vuuvkYgvGN
   quGl2eMTOdGZ9G4FyzA/aWc9HTYEYiUad7VpDh0VQcpoUukOsAu2mjXry
   Ojtwe1KvfnLabMuRdg6o1preIKaDF0gQRgqxc8zbnhdvHJhp2hLkUycp+
   YU7Y55z5wyIgwwcSo1ihusRDbbwi8azCmyRpkpLEdv2d6BZhPAw9X9Duh
   4wZBBO22eUwgYNOTiS+v88oRT16Fql7P4QjsijQK1v08/pafeLLQcc1f7
   w==;
X-CSE-ConnectionGUID: txOvsKiOQZOuo8u+7cI3VQ==
X-CSE-MsgGUID: vt5/CMCJQfexgx9axy746A==
X-IPAS-Result: =?us-ascii?q?A0AFAAC+NMFn/4oQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBGgUBAQEBCwGBQAEwUgd0AoEKEkiIIQOETl+IdAOXP4ZVg?=
 =?us-ascii?q?SUDVg8BAQENAi4BDAkEAQGFBwKLEgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBQEBAQIBBwWBDhOFewEMhloBAQEBAwERZxACAQgRBAEBHhEnCh0IA?=
 =?us-ascii?q?gQOBQgagmGCHA07AwEQoyMBgUACiit4gTSBAYNoAkPbbwYYgTABiE4BKoEyh?=
 =?us-ascii?q?A+EdycbG4FygVd5gW8+gQWBXAEDGIEdK4QTgi8Egi9Fdi+DPYY/EocGgQ6II?=
 =?us-ascii?q?ZFJUnUiAyYzLAFVExcLBwWBKUgDKjQxI4EjBTQKNzkBggtpSToCDQI1gh4kW?=
 =?us-ascii?q?IIrgh2COYRDXC8DAwMDgymFUoIRgV0DAxYQgx93HIR7hEwdQAMLbT03FBsFB?=
 =?us-ascii?q?IE1BZ9oBwMQWgE8hD89USxPC4E5GZMhUo8EgXuhcgoog3OMGI05iC0XhAONC?=
 =?us-ascii?q?JlLmH0igjaLLZsCAgQCBAUCDwEBBoFnPIFHCwdwFTuCZ1IZD5QagxTFPHgCO?=
 =?us-ascii?q?gIHCwEBAwmPaIF9AQE?=
IronPort-PHdr: A9a23:FK5hzxUM0p8Mhx1zhStyxtaeCk7V8K3PAWYlg6HPw5pHdqClupP6M
 1OavrNmjUTCWsPQ7PcXw+bVsqW1QWUb+t7Bq3ENdpVQSgUIwdsbhQ0uAcOJSAX7IffmYjZ8H
 ZFqX15+9Hb9Ok9QcPs=
IronPort-Data: A9a23:8Sj/aqwLc8iG3AV+OK56t+drxyrEfRIJ4+MujC+fZmUNrF6WrkUCy
 jAeCmiEOvqKNzCjf9AkO4y18UpXvZ+Hyt8yTwJqr1hgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 IiaT/H3Ygf/hmYuaDJMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJF0mGpMD2edQOFNp6
 PtINXNSZTHYudvjldpXSsE07igiBMDvOIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNU+QC/FMEg9/5JYWme6kg3DlaTxwo1OOrq1x6G/WpOB0+OSwa4uMIYPSFa25mG6Gu
 j+B1EHSICgUOcyQ2WuM4mPz2rHmyHaTtIU6UefQGuRRqEyUzXAUTQUfSVC7rOKRjk+lR8kZO
 ksf5i02t68w+Ue3CN7nUHWFTGWstxoYXZ9UVuY98gzIkvOS6AeCDW9CRTlEADA7iPILqfUR/
 gbht/viBCdkt/ueTnf1y1tehWra1fQ9RYPaWRI5cA==
IronPort-HdrOrdr: A9a23:cx/FQqPkTccEhMBcT4f255DYdb4zR+YMi2TDiHoBKiC9I/b5qy
 nxppUmPEfP+UgssREb9expOMG7MBXhHO1OkPgs1NaZLUfbUQSTXftfBOfZslnd8mjFh5FgPM
 RbAulD4b/LfCVHZK/BiWHSfadDsby6GeKT9JvjJhxWPHhXgtRbnnxE43GgYzVLrWd9dP0E/b
 Onl7l6jgvlU046Ku68AX4IVfXCodrkqLLKCCRtOzcXrCO1oXeN8rDVLzi0ty1yb9pI+9gf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyTqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeqUMKiGXoxEcLk/aJAw7SOPAxw76xtSGpsnbIiesMlJ
 6jGVjp76a/QymwxxgVrOK4Jy2C3nDE00bK19Rjz0C2leAlGeJsRUt1xjIOLH8NcRiKnbwPAa
 1gCtrR6+1Rdk7fZ3fFvnN3yNjpRXgrGAyaK3Jy9/B9/gIm10yR9XFojvA3jzMF7tYwWpNE7+
 PLPuBhk6xPVNYfaeZ4CP0aScW6B2TRSVaUWVjibmjPBeUCITbAupT36LI66KWjf4EJ1oI7nN
 DEXElDvWA/dkryAYmF3YFN8BrKXGKhNA6dhv129tx8oPnxVbDrOSqMRBQnlNahuewWBonBV/
 O6KPttcrfexKvVaM90NiHFKu9vwCMlIbkoU/4AKiWznv4=
X-Talos-CUID: 9a23:KzfFG2NXaPgl/O5DRDlA6lU3G+ccQFrAyyfNYBCzKD1XcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AWF4rsA0KNvKR1SQNn4xC1FDFBzUj/bjzT2sourc?=
 =?us-ascii?q?/tcSUOjwhMieM02jpa9py?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Feb 2025 04:05:16 +0000
Received: from alln-opgw-3.cisco.com (alln-opgw-3.cisco.com [173.37.147.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 506AF180001A7
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Feb 2025 04:05:16 +0000 (GMT)
X-CSE-ConnectionGUID: vvp6qx3ISkq6/pqkJunwFA==
X-CSE-MsgGUID: 5ljPnm17Qomrk41i2rLkWA==
Authentication-Results: alln-opgw-3.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208,217";a="22324587"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by alln-opgw-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Feb 2025 04:05:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYOBEAgqBB3XXim1ZlvwZTn9LM24YfM5HgLwVzUwnWXOutfdXmSh/si97+IpfsOS0BiKyYwwqwHmItS3zSLTeE/2KW4cP6oYG8N6keo7KX/f3GQWP110Prxn1OaYBpaiDioL/l4xQnqQqxzAoj8i0DoQgG+bgpGj0fXkxAvmAw8PYEBMbpyLnseVNmB82xnCweJH2xEbk0aZd9RZF1t9gFBp+cOJG86MusuXaWSM3737Dguw1mP2ITRmoHZ3wLvu8TCw8bmmR13vGjRgLwG7j9tRE37eVOh6StQii2pOHDj0ZdtGyOOEmDl24m3U/fXi5QjccDfiLk6tN4r5zmgjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iH/fgQKvwHt0nctdee8ksPG+vAq0gp+a0Vhh2/3Qs4=;
 b=ZTpC72h8ZNW5Qy7m40GBQ3GUagHnOKnsw2tar0A6/DuaC0cDBzidtqpNpUlphxJHXbt4NUE21cyym+0q53ABYMnz3XfkVPmKF1L/bXRaAoB+8ZrpPhZQaexd56lDjlPhHfyl13OhTsXPQyuY1d/W0+wkTLzewVOsBFYEvIz26U0Du6FIjeZ5N5mUj74149Y+QxWSGz3Hl/na+04z3FcoMJfL0O55osqdqfbv93ipOJuc1J2M0kqMWqhfwUHaZ6tdolQSysrGA2V5XB/YyN5b3mbgJuHX/HI4TWEVGtqM3z6c20tw1mfkooh4ivLskbJSB+WN99EMtVse7xTUG/D3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5677.namprd11.prod.outlook.com (2603:10b6:a03:37e::22)
 by SN7PR11MB7439.namprd11.prod.outlook.com (2603:10b6:806:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 04:05:13 +0000
Received: from SJ0PR11MB5677.namprd11.prod.outlook.com
 ([fe80::d83d:c581:8bef:dbd0]) by SJ0PR11MB5677.namprd11.prod.outlook.com
 ([fe80::d83d:c581:8bef:dbd0%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 04:05:13 +0000
From: "Madhu Marri" <madmarri@cisco.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as Patched
Thread-Topic: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751
 as Patched
Thread-Index: AQHbavsGVdFVIpXR8E+jn1C/0tRT8LMteMgbgC7dBQk=
Date: Fri, 28 Feb 2025 04:05:13 +0000
Message-ID: 
 <SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2@SJ0PR11MB5677.namprd11.prod.outlook.com>
References: <20250120052019.2945142-1-madmarri@cisco.com>
 <SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2@SJ0PR11MB5677.namprd11.prod.outlook.com>
In-Reply-To: 
 <SJ0PR11MB5677B53A0FB2297F53F094E5CDEE2@SJ0PR11MB5677.namprd11.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5677:EE_|SN7PR11MB7439:EE_
x-ms-office365-filtering-correlation-id: 639c5b9f-e073-4ca3-b366-08dd57ad19e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|8096899003|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?CzgSWK1uYiUxhswODs+oT5vXTR7ODKQQDJ2znVg8Q+8Nq94f5npGqWEUta?=
 =?iso-8859-1?Q?QQxfRCTV3uYhAHe7z7Xfj91LpVcooqI41nFjceoXY9Nce7BS1bZwV4R5lN?=
 =?iso-8859-1?Q?AaCJIE/p2/OWAi6jhIkhoTb1X57SDUohyCUyPmNuwt8OGWvKSs0cQEoaug?=
 =?iso-8859-1?Q?WLO3FV/PelqGEFEnjQI7A2ZXFNcOAiuulMcauq6IwcOW+ldM9ozrN26WWq?=
 =?iso-8859-1?Q?OIbdQqwCVI5Mv9CyCxC2ZuZ5PlZCummSnckyfr2Nwuxyc46wkXBAqOj8FQ?=
 =?iso-8859-1?Q?jHmvNSvD/StxkkVXlgRqhfpIrCluv5suJu29BmhOvn0Hp4p2khYZ6CbZmp?=
 =?iso-8859-1?Q?zUYDaz1UXLgREnedADePBOhRzm0QpH87HrHVUgFDQyB5E8JI7bw6dylnxm?=
 =?iso-8859-1?Q?WF9OiJ2Qky1iZLfEWzOd7D2KV3W3dYlgtflhnMSI24dGkFKteWE1+PbjLd?=
 =?iso-8859-1?Q?pClneqPi/o/5FiOEQ0Hj3MHVblR2yUfcn1V7XKoVazHo8WfU3RAoeKYJw0?=
 =?iso-8859-1?Q?ALkp769y1tHBe7qzlCe5+Rx+ibB1e31Z/Xz9yJCpRD/69BQfxpxrO8XNFS?=
 =?iso-8859-1?Q?VAMdEblIyoXDh8FLIhbdv6PXFCNvH8a2l0guEPkB2/QEU43EUtHyKMtVU6?=
 =?iso-8859-1?Q?ljV4mnHgs2B9kttlhSNCpQaDWiYOmB+pxT/vjlCPbCDT1YD670WZddLXgV?=
 =?iso-8859-1?Q?9RDemvyMgy5U8qO7Zncy5XxCdDwscxf+b7g435oks6k2n8qIynzHDv/BTK?=
 =?iso-8859-1?Q?25HqLJT76Fc/2hshp88vigkhXw3P46faL4eYs7tubdAPkmIlIXzPzzBX+E?=
 =?iso-8859-1?Q?WembzvmwrtK5OTd1ZM0Zfj7f72e5RbiROGUJEZZFO82OwenFLUO496Zbsr?=
 =?iso-8859-1?Q?SQtZmHWos+ezbInNYZwHX2uouqn963XgGgETKEHVYwXgjWqs3H71z3tTE/?=
 =?iso-8859-1?Q?y2yqQaGSnEaxLaJzGCtIffLpCBTfMiN+m/KdiL7m/ARVavdTjuYrOTNVhl?=
 =?iso-8859-1?Q?57PckgC75AduPo8dNgnNUfuvWPQLhCEkimdWICLDZDJuTF2nwwrtvMSoG1?=
 =?iso-8859-1?Q?E1ZmLxF6TNDnHVDJj4v2otYa6QHknozlz8rOGGl1atH2ys2L0s/CpWWkTK?=
 =?iso-8859-1?Q?DfGpivpYAo+nFnYIJj8HNSiYCTEbmlSuZzsHTPNN3ZkCdN6KWeusoZLGTh?=
 =?iso-8859-1?Q?f5ivAG7XCHeeU41axgXWwHSUhMsN8yfw2TtxWCe4jsAB0uyKL4wI6aP1KS?=
 =?iso-8859-1?Q?fXITPfQQu43j46ozHPQoIHr38kysUTBBGosc9TQqcWV7Oc+4lQBIjk8cBL?=
 =?iso-8859-1?Q?sPUjjOvYmo08W5ytVVwkZ/aUanNi5Qx7K7fVkIqozwyLZaTsOruRmElU+F?=
 =?iso-8859-1?Q?5BvSDWGfU5mKpPVzwBpALOA11kZNozq+M9xk5QFyFn6OIAIy7FbVDSrzKA?=
 =?iso-8859-1?Q?LFcUC2p3KM1mam7wyipDoTSqMUmnITU1Zr9o1VEjnkMZ1ioYdW7yj2O5BV?=
 =?iso-8859-1?Q?i085/VPB/RuldmN0Q9hZOTiza6bBrHuzqDotHyK/goRQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5677.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(8096899003)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?mCfw5BnzDHC9Jk4SSINn6998qoob5+4KA4nYUYkDkRxAgf1az9b0j/fVtn?=
 =?iso-8859-1?Q?lBCnoGJNi8ywbaGtITX79ma5W9xM23PHn7vYFwWf+yTR9SXSPKQalAmUAZ?=
 =?iso-8859-1?Q?qkDBQ3ZnoJD8snBdZere/JQaR0uNPMR1PZ+oF6fWjv0UegkJ2y8i3bB1S1?=
 =?iso-8859-1?Q?qLofuX2Sup1mdyDscRH9u9LHKOwJ/p19mSDfFCZ7xlfxyZMPobuNVh38GQ?=
 =?iso-8859-1?Q?EVvipBzvH28zREkhJlMtegXPWgmSdqo5Hz/gWIlR+3CIQJVZZxTBgC/ndB?=
 =?iso-8859-1?Q?h12z9cP1IU2g2fDmqtLdqhU7kugzu+MW48VpwCxgkRJQ2Kz1WCOSLEmSWR?=
 =?iso-8859-1?Q?XL+XBEXN278Bkx3wvTEGfeHvG0Dv2Bu8sPYmKcHRQMCrMUIrIuvcl1+Dmm?=
 =?iso-8859-1?Q?z0t+YD2Nwtz64jqPKsgXvyJeO/Wr2ibKFm3WCYh/g+gsaSMlN1j2WWiqPn?=
 =?iso-8859-1?Q?unSwVMLas0Gu6q9dhn/oV/huuDYiEp+JC3bdovVXeMVx0qkzn7th76Lh41?=
 =?iso-8859-1?Q?wfdfZSfhcmorQd5ZeSxxOcQq8vlEGzUl6XYMfGYmWkzDujaqjwMLOZeiOz?=
 =?iso-8859-1?Q?u1tP2wR7EqcJc05CsH4uaxvMCd/x8wwY3pOTILQVGJvL/oRdrDLF27bf5W?=
 =?iso-8859-1?Q?GbiTVVL/5KjQWmq5Gxdo0ozlSto9pWG/Rwp7ECl2wcUNu6aYN99EvKllJ9?=
 =?iso-8859-1?Q?LDaKBCmv4T7XPn4a78oF9XwwxWn5X5Qm4I0JVyw80UTa6hEGUSluLfavRT?=
 =?iso-8859-1?Q?gt7OJj7tZ87RbGla4NonaDGeKXJxsxfpMuaZJ157OIiK1uZCJoV6zj5cJt?=
 =?iso-8859-1?Q?FaPGiLAel4Kl87ZQUSxb6SqnROYddhwIZEpLCsqjAZ7zd0N372NMiEPVR1?=
 =?iso-8859-1?Q?rvBOAbCgmITVyYbtwdK1nW1gkbasO2kxOXtNqZn6N4hni24jOGOvSGDyPY?=
 =?iso-8859-1?Q?rsMkgorFj8mC+WTFnlbzyn+3swbxMvkNudR04L594HvwdiNyCIy1j97wfR?=
 =?iso-8859-1?Q?bXoITcA4C2IP8qYDj9EFrLaP7qwYzy9I8njRXeX1apVncKbsK3uLMlhom2?=
 =?iso-8859-1?Q?/oSdFHmuL9hhMCNFrrWJLFR9MD73isto6YmJcZT0tz/YlcFnHXzFS6Lpl7?=
 =?iso-8859-1?Q?5n9En357Wjd5RwsNR+/0DQUJOOHLy53lw//J7UWQZb6K/IgyjgtXcy8gh8?=
 =?iso-8859-1?Q?hP0mj77Wv0fzveLbty3rnzPZcwxbtjRKL78zRpjkemvdKOJEPCDjj1IS0D?=
 =?iso-8859-1?Q?XGQHe8Jqo1/VUCB84z+hj5yyj8QhR3nO1Oq8Ol4QCF2wbXVz8Ti6ViJ6Hk?=
 =?iso-8859-1?Q?Av3cEZ4U98tffMqx1bbxUJBwlik+KXE7I30wYdenFjTVdMFc41RifZ9RaP?=
 =?iso-8859-1?Q?7TGbYUuSkd/oBRftArYW1T5fluimSOTPWbLdhXU4B5a4BS0oNL4stJC1G3?=
 =?iso-8859-1?Q?fQ5HmzWW/1AGU5Nt3YxsDDEmeU9NxqIsiJzG6gIsyLzU6zM4ZzCcSPysH9?=
 =?iso-8859-1?Q?jhrU3JqDntD5Z6xUTJEyaY0mNzpY1PLKeE4rDRIJBlxBElF+JSVbF3rLl6?=
 =?iso-8859-1?Q?nXKBKl+YymbiOCdgEmGOxGUxcPE2YkopWWPEbCEvDJi2KEN5Or4WZknDdf?=
 =?iso-8859-1?Q?fi1/DDgNqzLf03Q2+sAywxuI0M31ym4Od7bcdBwfZYNkoLJ4jlHht8Sw9b?=
 =?iso-8859-1?Q?xV9uSrqK79E8l3Pfe40=3D?=
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5677.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639c5b9f-e073-4ca3-b366-08dd57ad19e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 04:05:13.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGW5k2EG9WvFbGLRWbp+iBMP2/cfBxKCNDdBjx6YJJXNLgwd4ts3UH611JKuvkkBSVdFw0NNn0iHFs4jQEgpTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
X-Outbound-SMTP-Client: 173.37.147.251, alln-opgw-3.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2SJ0PR11MB5677namp_"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Feb 2025 09:34:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1136

--_000_SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2SJ0PR11MB5677namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Team,

Any updates on the patch review.

Thanks
Madhu

________________________________
From: Madhu Marri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) <mad=
marri@cisco.com>
Sent: Monday, February 3, 2025 9:15 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: xe-linux-external(mailer list) <xe-linux-external@cisco.com>
Subject: Re: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-1075=
1 as Patched

Hi Team,

Could you please update on this patchset review.

Thanks
Madhu

________________________________
From: Madhu Marri <madmarri@cisco.com>
Sent: Monday, January 20, 2025 10:50 AM
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: xe-linux-external(mailer list) <xe-linux-external@cisco.com>; Madhu Mar=
ri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) <madmarri@cisco.com=
>
Subject: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2020-10751 as=
 Patched

Bug Details: https://nvd.nist.gov/vuln/detail/CVE-2020-10751
Type: Security Advisory
CVE: CVE-2020-10751
Score: 6.1
Patch: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3Dfb73974172ff

Analysis:
- This is a selinux cve which is addressed in kernel.
- The fix is available at [1].
- Hence, marking the CVE as patched.

Reference:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfb73974172ff

Signed-off-by: Madhu Marri <madmarri@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security=
/selinux/selinux_common.inc
index cecb0b5..d8c91ac 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -19,3 +19,5 @@ do_install() {
 }

 CVE_PRODUCT ?=3D "kernel:selinux"
+
+CVE_STATUS[CVE-2020-10751] =3D "fixed-version: Fix is present in the curre=
nt kernel version."
--
2.44.1


--_000_SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2SJ0PR11MB5677namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Team,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Any updates on the patch review.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Madhu</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Madhu Marri -X (madma=
rri - E INFOCHIPS PRIVATE LIMITED at Cisco) &lt;madmarri@cisco.com&gt;<br>
<b>Sent:</b> Monday, February 3, 2025 9:15 AM<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Cc:</b> xe-linux-external(mailer list) &lt;xe-linux-external@cisco.com&g=
t;<br>
<b>Subject:</b> Re: [meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-20=
20-10751 as Patched</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div class=3D"x_elementToProof" style=3D"direction:ltr; font-family:Aptos,A=
ptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-si=
ze:12pt; color:rgb(0,0,0)">
Hi Team,</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Could you please update on this patchset review.&nbsp;</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Thanks</div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Madhu</div>
<div id=3D"x_x_appendonsend"></div>
<div style=3D"direction:ltr; font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSF=
ontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"direction:ltr; display:inline-block; width:98%">
<div dir=3D"ltr" id=3D"x_x_divRplyFwdMsg"><span style=3D"font-family:Calibr=
i,sans-serif; font-size:11pt; color:rgb(0,0,0)"><b>From:</b>&nbsp;Madhu Mar=
ri &lt;madmarri@cisco.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, January 20, 2025 10:50 AM<br>
<b>To:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;<br>
<b>Cc:</b>&nbsp;xe-linux-external(mailer list) &lt;xe-linux-external@cisco.=
com&gt;; Madhu Marri -X (madmarri - E INFOCHIPS PRIVATE LIMITED at Cisco) &=
lt;madmarri@cisco.com&gt;<br>
<b>Subject:</b>&nbsp;[meta-selinux] [scarthgap] [PATCH] selinux: Mark CVE-2=
020-10751 as Patched</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction:ltr; font-size:11pt">Bug Details: <a href=3D"https:=
//nvd.nist.gov/vuln/detail/CVE-2020-10751" data-auth=3D"NotApplicable" id=
=3D"OWAfe63b8fa-bf09-8c45-3b00-0f99283c4e42" class=3D"x_OWAAutoLink">
https://nvd.nist.gov/vuln/detail/CVE-2020-10751</a><br>
Type: Security Advisory<br>
CVE: CVE-2020-10751<br>
Score: 6.1<br>
Patch: <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/commit/?id=3Dfb73974172ff" data-auth=3D"NotApplicable" id=3D"OWA4=
554957d-5e47-260d-47e7-43505896bf6a" class=3D"x_OWAAutoLink">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfb73974172ff</a><br>
<br>
Analysis:<br>
- This is a selinux cve which is addressed in kernel.<br>
- The fix is available at [1].<br>
- Hence, marking the CVE as patched.<br>
<br>
Reference:<br>
[1] <a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/lin=
ux.git/commit/?id=3Dfb73974172ff" data-auth=3D"NotApplicable" id=3D"OWA751a=
8d58-7be3-19f4-4107-67584dba94ae" class=3D"x_OWAAutoLink">
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dfb73974172ff</a><br>
<br>
Signed-off-by: Madhu Marri &lt;madmarri@cisco.com&gt;<br>
---<br>
&nbsp;recipes-security/selinux/selinux_common.inc | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security=
/selinux/selinux_common.inc<br>
index cecb0b5..d8c91ac 100644<br>
--- a/recipes-security/selinux/selinux_common.inc<br>
+++ b/recipes-security/selinux/selinux_common.inc<br>
@@ -19,3 +19,5 @@ do_install() {<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;CVE_PRODUCT ?=3D &quot;kernel:selinux&quot;<br>
+<br>
+CVE_STATUS[CVE-2020-10751] =3D &quot;fixed-version: Fix is present in the =
current kernel version.&quot;<br>
--<br>
2.44.1<br>
<br>
</div>
</div>
</body>
</html>

--_000_SJ0PR11MB567701EFE9AA4C2E937906C4CDCC2SJ0PR11MB5677namp_--

