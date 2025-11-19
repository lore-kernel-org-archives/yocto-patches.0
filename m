Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27232CF58E5
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 20:21:21 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16761.1763583674773656214
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 12:21:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DAHODHMa;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88057f5d041so1399466d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 12:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763583674; x=1764188474; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8AOPhA5kcVMpPIr3iUYQhgmpH/k332Xqclr4WQmH+kQ=;
        b=DAHODHMajnPUlgpzbUCs9D+/0VdJvKachDldKD/k9qORVxDEugR5kCmu3N5266dNCY
         04izjefoof7F4umXz3TMjyOn+JD++YUmKTLuOLdVj5GaQNoJoY100ER8KGy7dGku08xM
         lTV+BcjvCXLY7A4G0VLUhFgP5sMNjuhcuJrds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763583674; x=1764188474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AOPhA5kcVMpPIr3iUYQhgmpH/k332Xqclr4WQmH+kQ=;
        b=jgBDoXjY/CPDx/T+PeC6YI+VmvgVQcx6qQ3xhlvpqce3OlOfZoiLAAm5EQkhPTDX8L
         XzvgXTqxD6wvPiRMpoavQsSPm41hcfp9YOFDo7ObEn5UqLLaaxOUCVC5cZMWKJHCqea/
         qMiPRUA/Fhe6Y4obXAYB+pclDTpbTS+xNx1joT9sqMTMAD9bVjOAdfEqLtTH9btkZm4n
         8mo9BslZawIEg5sKnzy8sXlKxFXX/xfo1CJDeD2Pdd2GoIuTfw9AhbHFUaKyWa3u20oy
         uqaaDzpzymTJiuUhjWJzMZwEgn4+Z7NSjn5Z605ajoNqpdLSFQ9UJ16Ngpiu/3/bdg0p
         e9Qg==
X-Gm-Message-State: AOJu0Yxn/rcsvE/4mnhh8sDjLPs1+k0Nr83vqpgrVCamhPAitzcyNucE
	X4tC3/eCjGejG4dR50tRKUcxIIfubF62PvetQwLxN7JUX28p5w7568NxlnUCVPBQcvs=
X-Gm-Gg: ASbGncvtBsKvBPSkm53AnRPlS+7tzSvsPQnMAGpIY9tqmnByjdMeWBz/HP8zgWbxe/i
	1YDo2GPcTNccZsq1BOi4xKyhlWH7dR5c93POpati7xgDjNlCS5x+oBBud5p3hlEu+k49L6LZ/ov
	TVxjTIZWorlNiuRjhKA1VetrZLaSzTTEXhBSZ83AC/ReUQDkPrDt7/M9PoGvEM+tq2RbMy8pORr
	VH0BwrKrISxGjUvTEdgDSlVo6sAr0M8x10WR0n51DUnXrWSrU8hp5QjzzeQQrRVj323pIrLdNv3
	kuNSpkAlQeUR8VPDrfxXPwaSRK2q3JnuoKeBb2sWK3WughLGr4ntSBd2cOr1PgL6wcnehEXoo/s
	yLw69D3yWKNAFUnUKA+p4XCRHDogybFHW+Qhp+IVcNkOEviCJfSedP7SrL7cimQUamK0EH4ikoY
	Q1y0KkCghSGn8XAhC2X8g5QNXAiQuGIQFv3Iw+Djn+WnIRcQ==
X-Google-Smtp-Source: AGHT+IHGVEsV05DoAUDBzjLX++6f5AwnMApjGmuj5zk3uD2QIQuEgFtuasgntQDY1BImJNuWqamllw==
X-Received: by 2002:ad4:5c6f:0:b0:87c:651:da29 with SMTP id 6a1803df08f44-8846e1319f9mr8746396d6.35.1763583672942;
        Wed, 19 Nov 2025 12:21:12 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e5744ddsm2490526d6.45.2025.11.19.12.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 12:21:11 -0800 (PST)
Date: Wed, 19 Nov 2025 15:20:41 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Hitendra Prajapati <hprajapati@mvista.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com, 
    Jeremy Puhlman <jpuhlman@mvista.com>
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH] suricata: fix
 CVE-2024-55627 && CVE-2024-55628
In-Reply-To: <e5c577a8-9350-46e0-8161-08769856f33c@mvista.com>
Message-ID: <ecb6f704-285a-6e1b-e397-d5086d611b2d@konsulko.com>
References: <1863D7AC069BDA45.18650@lists.yoctoproject.org> <e5c577a8-9350-46e0-8161-08769856f33c@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 20:21:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2620

On Wed, 19 Nov 2025, Hitendra Prajapati wrote:

> Hi Team,
>
> Any Update ?

I am working on it, but do have a day job, please be patient.  I should
have a patch series up later this week or on the weekend.  Note that I
have removed Armin from the CC list, as I suspect he does not want to
be bothered after stepping down as maintainer.

Thanks,

Scott

> On 10/09/25 11:53 am, Hitendra Prajapati via lists.yoctoproject.org wrote:
> > Backport fixes for:
> >
> > * CVE-2024-55627 - Upstream-Status: Backport
> > fromhttps://github.com/OISF/suricata/commit/0dc364aef2dec122fc0e7ee4c190864f4cc5f1bd
> > &&https://github.com/OISF/suricata/commit/949bfeca0e5f92212dc3d79f4a87c7c482d376aa
> > &&https://github.com/OISF/suricata/commit/7d47fcf7f7fefacd2b0d8f482534a83b35a3c45e
> > * CVE-2024-55628 - Upstream-Status: Backport
> > fromhttps://github.com/OISF/suricata/commit/58c41a7fa99f62d9a8688e970ab1a9b09c79723a
> > &&https://github.com/OISF/suricata/commit/284ad462fcb2e47f1518a1abc19e27ca84c6972e
> > &&https://github.com/OISF/suricata/commit/5edb84fe234f47a0fedfbf9b10b49699152fe8cb
> > &&https://github.com/OISF/suricata/commit/71212b78bd1b7b841c9d9a907d0b3eea71a54060
> >
> > Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > ---
> >   .../suricata/files/CVE-2024-55627-001.patch   |   59 +
> >   .../suricata/files/CVE-2024-55627-002.patch   |   44 +
> >   .../suricata/files/CVE-2024-55627-003.patch   |   41 +
> >   .../suricata/files/CVE-2024-55628-001.patch   |  738 +++
> >   .../suricata/files/CVE-2024-55628-002.patch   | 4877 +++++++++++++++++
> >   .../suricata/files/CVE-2024-55628-003.patch   |  114 +
> >   .../suricata/files/CVE-2024-55628-004.patch   |  510 ++
> >   recipes-ids/suricata/suricata_7.0.0.bb        |    7 +
> >   8 files changed, 6390 insertions(+)
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55627-001.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55627-002.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55627-003.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55628-001.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55628-002.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55628-003.patch
> >   create mode 100644 recipes-ids/suricata/files/CVE-2024-55628-004.patch
> >
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55627-001.patch
> > b/recipes-ids/suricata/files/CVE-2024-55627-001.patch
> > new file mode 100644
> > index 0000000..50b4f06
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55627-001.patch
> > @@ -0,0 +1,59 @@
> > +From 0dc364aef2dec122fc0e7ee4c190864f4cc5f1bd Mon Sep 17 00:00:00 2001
> > +From: Philippe Antoine<pantoine@oisf.net>
> > +Date: Thu, 21 Nov 2024 14:55:32 +0100
> > +Subject: [PATCH] util/streaming-buffer: fix regions intersection
> > +
> > +This was not a problem for current callers in Suricata,
> > +as RegionsIntersect is only called through StreamingBufferInsertAt
> > +which is only used by TCP...
> > +
> > +And TCP uses default region gap = 256kb, and only calls
> > +StreamingBufferInsertAt with a u16, so TCP never inserts a new
> > +data that will strictly contain an existing region augmented
> > +with region gap, which was the only case where RegionsIntersect
> > +returned the wrong result, which could later lead to a
> > +buffer overflow.
> > +
> > +Ticket: 7393
> > +(cherry picked from commit 282509f70c4ce805098e59535af445362e3e9ebd)
> > +
> > +CVE: CVE-2024-55627
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/0dc364aef2dec122fc0e7ee4c190864f4cc5f1bd]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + src/util-streaming-buffer.c | 19 ++++++++-----------
> > + 1 file changed, 8 insertions(+), 11 deletions(-)
> > +
> > +diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
> > +index 7608b50..d1d20e8 100644
> > +--- a/src/util-streaming-buffer.c
> > ++++ b/src/util-streaming-buffer.c
> > +@@ -133,17 +133,14 @@ static inline bool RegionsIntersect(const
> > StreamingBuffer *sb, const StreamingBu
> > +     SCLogDebug("r %p: %" PRIu64 "/%" PRIu64 " - adjusted %" PRIu64 "/%"
> > PRIu64, r, r->stream_offset,
> > +             r->stream_offset + r->buf_size, reg_o, reg_re);
> > +     /* check if data range intersects with region range */
> > +-    if (offset >= reg_o && offset <= reg_re) {
> > +-        SCLogDebug("r %p is in-scope", r);
> > +-        return true;
> > +-    }
> > +-    if (re >= reg_o && re <= reg_re) {
> > +-        SCLogDebug("r %p is in-scope: %" PRIu64 " >= %" PRIu64 " && %"
> > PRIu64 " <= %" PRIu64, r, re,
> > +-                reg_o, re, reg_re);
> > +-        return true;
> > +-    }
> > +-    SCLogDebug("r %p is out of scope: %" PRIu64 "/%" PRIu64, r, offset,
> > re);
> > +-    return false;
> > ++    /* [offset:re] and [reg_o:reg_re] do not intersect if and only if
> > ++     * re < reg_o or if reg_re < offset (one segment is strictly before
> > the other)
> > ++     * trusting that offset<=re and reg_o<=reg_re
> > ++     */
> > ++    if (re < reg_o || reg_re < offset) {
> > ++        return false;
> > ++    }
> > ++    return true;
> > + }
> > +
> > + /** \internal
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55627-002.patch
> > b/recipes-ids/suricata/files/CVE-2024-55627-002.patch
> > new file mode 100644
> > index 0000000..8e2ca6b
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55627-002.patch
> > @@ -0,0 +1,44 @@
> > +From 949bfeca0e5f92212dc3d79f4a87c7c482d376aa Mon Sep 17 00:00:00 2001
> > +From: Philippe Antoine<pantoine@oisf.net>
> > +Date: Thu, 21 Nov 2024 15:17:21 +0100
> > +Subject: [PATCH] util/streaming-buffer: check need to grow region
> > +
> > +Ticket: 7393
> > +
> > +As it was possible before earlier patches to get here
> > +with mem_size lesser than start->buf_size,
> > +which caused then an unsigned underflow and a buffer overflow.
> > +
> > +(cherry picked from commit 8900041405dbb5f9584edae994af2100733fb4be)
> > +
> > +CVE: CVE-2024-55627
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/949bfeca0e5f92212dc3d79f4a87c7c482d376aa]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + src/util-streaming-buffer.c | 10 +++++++---
> > + 1 file changed, 7 insertions(+), 3 deletions(-)
> > +
> > +diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
> > +index d1d20e8..2625e49 100644
> > +--- a/src/util-streaming-buffer.c
> > ++++ b/src/util-streaming-buffer.c
> > +@@ -931,9 +931,13 @@ static inline void
> > StreamingBufferSlideToOffsetWithRegions(
> > +                     goto done;
> > +                 } else {
> > +                     /* using "main", expand to include "next" */
> > +-                    if (GrowRegionToSize(sb, cfg, start, mem_size) != 0) {
> > +-                        new_mem_size = new_data_size;
> > +-                        goto just_main;
> > ++                    if (mem_size > start->buf_size) {
> > ++                        // Check that start->buf_size is actually not big
> > enough
> > ++                        // As mem_size computation and earlier checks do
> > not make it clear.
> > ++                        if (GrowRegionToSize(sb, cfg, start, mem_size) !=
> > 0) {
> > ++                            new_mem_size = new_data_size;
> > ++                            goto just_main;
> > ++                        }
> > +                     }
> > +                     SCLogDebug("start->buf now size %u", mem_size);
> > +
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55627-003.patch
> > b/recipes-ids/suricata/files/CVE-2024-55627-003.patch
> > new file mode 100644
> > index 0000000..63d5016
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55627-003.patch
> > @@ -0,0 +1,41 @@
> > +From 7d47fcf7f7fefacd2b0d8f482534a83b35a3c45e Mon Sep 17 00:00:00 2001
> > +From: Philippe Antoine<pantoine@oisf.net>
> > +Date: Thu, 21 Nov 2024 15:20:44 +0100
> > +Subject: [PATCH] util/streaming-buffer: add extra safety check
> > +
> > +Ticket: 7393
> > +
> > +Check if GrowRegionToSize is called with an argument
> > +trying to shrink the region size, and if so do nothing,
> > +ie do not try to shrink, and just return ok.
> > +
> > +This way, we avoid a buffer overflow from memeset using an
> > +unsigned having underflowed.
> > +
> > +(cherry picked from commit 9a53ec43b13f0039a083950511a18bf6f408e432)
> > +
> > +CVE: CVE-2024-55627
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/7d47fcf7f7fefacd2b0d8f482534a83b35a3c45e]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + src/util-streaming-buffer.c | 4 ++++
> > + 1 file changed, 4 insertions(+)
> > +
> > +diff --git a/src/util-streaming-buffer.c b/src/util-streaming-buffer.c
> > +index 2625e49..077f8af 100644
> > +--- a/src/util-streaming-buffer.c
> > ++++ b/src/util-streaming-buffer.c
> > +@@ -715,6 +715,10 @@ static inline int WARN_UNUSED
> > GrowRegionToSize(StreamingBuffer *sb,
> > +     /* try to grow in multiples of cfg->buf_size */
> > +     const uint32_t grow = ToNextMultipleOf(size, cfg->buf_size);
> > +     SCLogDebug("grow %u", grow);
> > ++    if (grow <= region->buf_size) {
> > ++        // do not try to shrink, and do not memset with diff having
> > unsigned underflow
> > ++        return SC_OK;
> > ++    }
> > +
> > +     void *ptr = REALLOC(cfg, region->buf, region->buf_size, grow);
> > +     if (ptr == NULL) {
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55628-001.patch
> > b/recipes-ids/suricata/files/CVE-2024-55628-001.patch
> > new file mode 100644
> > index 0000000..6371729
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55628-001.patch
> > @@ -0,0 +1,738 @@
> > +From 58c41a7fa99f62d9a8688e970ab1a9b09c79723a Mon Sep 17 00:00:00 2001
> > +From: Jason Ish<jason.ish@oisf.net>
> > +Date: Thu, 31 Oct 2024 15:40:40 -0600
> > +Subject: [PATCH] dns: truncate names larger than 1025 characters
> > +
> > +Once a name has gone over 1025 chars it will be truncated to 1025
> > +chars and no more labels will be added to it, however the name will
> > +continue to be parsed up to the label limit in attempt to find the end
> > +so parsing can continue.
> > +
> > +This introduces a new struct, DNSName which contains the name and any
> > +flags which indicate any name parsing errors which should not error
> > +out parsing the complete message, for example, infinite recursion
> > +after some labels are parsed can continue, or truncation of name where
> > +compression was used so we know the start of the next data to be
> > +parsed.
> > +
> > +This limits the logged DNS messages from being over our maximum size
> > +of 10Mb in the case of really long names.
> > +
> > +Ticket: #7280
> > +
> > +CVE: CVE-2024-55628
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/58c41a7fa99f62d9a8688e970ab1a9b09c79723a]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + rust/src/dns/dns.rs    |  41 +++++---
> > + rust/src/dns/log.rs    |  41 ++++----
> > + rust/src/dns/lua.rs    |  36 ++++---
> > + rust/src/dns/parser.rs | 231 ++++++++++++++++++++++++++++++++++++-----
> > + 4 files changed, 277 insertions(+), 72 deletions(-)
> > +
> > +diff --git a/rust/src/dns/dns.rs b/rust/src/dns/dns.rs
> > +index 382c76a..680bf7e 100644
> > +--- a/rust/src/dns/dns.rs
> > ++++ b/rust/src/dns/dns.rs
> > +@@ -144,7 +144,7 @@ pub struct DNSHeader {
> > +
> > + #[derive(Debug)]
> > + pub struct DNSQueryEntry {
> > +-    pub name: Vec<u8>,
> > ++    pub name: DNSName,
> > +     pub rrtype: u16,
> > +     pub rrclass: u16,
> > + }
> > +@@ -152,9 +152,9 @@ pub struct DNSQueryEntry {
> > + #[derive(Debug, PartialEq, Eq)]
> > + pub struct DNSRDataSOA {
> > +     /// Primary name server for this zone
> > +-    pub mname: Vec<u8>,
> > ++    pub mname: DNSName,
> > +     /// Authority's mailbox
> > +-    pub rname: Vec<u8>,
> > ++    pub rname: DNSName,
> > +     /// Serial version number
> > +     pub serial: u32,
> > +     /// Refresh interval (seconds)
> > +@@ -186,7 +186,22 @@ pub struct DNSRDataSRV {
> > +     /// Port
> > +     pub port: u16,
> > +     /// Target
> > +-    pub target: Vec<u8>,
> > ++    pub target: DNSName,
> > ++}
> > ++
> > ++bitflags! {
> > ++    #[derive(Default)]
> > ++    pub struct DNSNameFlags: u8 {
> > ++        const INFINITE_LOOP = 0b0000_0001;
> > ++        const TRUNCATED     = 0b0000_0010;
> > ++        const LABEL_LIMIT   = 0b0000_0100;
> > ++    }
> > ++}
> > ++
> > ++#[derive(Debug, Clone, PartialEq, Eq)]
> > ++pub struct DNSName {
> > ++    pub value: Vec<u8>,
> > ++    pub flags: DNSNameFlags,
> > + }
> > +
> > + /// Represents RData of various formats
> > +@@ -196,10 +211,10 @@ pub enum DNSRData {
> > +     A(Vec<u8>),
> > +     AAAA(Vec<u8>),
> > +     // RData is a domain name
> > +-    CNAME(Vec<u8>),
> > +-    PTR(Vec<u8>),
> > +-    MX(Vec<u8>),
> > +-    NS(Vec<u8>),
> > ++    CNAME(DNSName),
> > ++    PTR(DNSName),
> > ++    MX(DNSName),
> > ++    NS(DNSName),
> > +     // RData is text
> > +     TXT(Vec<u8>),
> > +     NULL(Vec<u8>),
> > +@@ -213,7 +228,7 @@ pub enum DNSRData {
> > +
> > + #[derive(Debug, PartialEq, Eq)]
> > + pub struct DNSAnswerEntry {
> > +-    pub name: Vec<u8>,
> > ++    pub name: DNSName,
> > +     pub rrtype: u16,
> > +     pub rrclass: u16,
> > +     pub ttl: u32,
> > +@@ -871,9 +886,9 @@ pub unsafe extern "C" fn rs_dns_tx_get_query_name(
> > +     if let Some(request) = &tx.request {
> > +         if (i as usize) < request.queries.len() {
> > +             let query = &request.queries[i as usize];
> > +-            if !query.name.is_empty() {
> > +-                *len = query.name.len() as u32;
> > +-                *buf = query.name.as_ptr();
> > ++            if !query.name.value.is_empty() {
> > ++                *len = query.name.value.len() as u32;
> > ++                *buf = query.name.value.as_ptr();
> > +                 return 1;
> > +             }
> > +         }
> > +@@ -904,7 +919,7 @@ pub unsafe extern "C" fn rs_dns_tx_get_query_rrtype(
> > +     if let Some(request) = &tx.request {
> > +         if (i as usize) < request.queries.len() {
> > +             let query = &request.queries[i as usize];
> > +-            if !query.name.is_empty() {
> > ++            if !query.name.value.is_empty() {
> > +                 *rrtype = query.rrtype;
> > +                 return 1;
> > +             }
> > +diff --git a/rust/src/dns/log.rs b/rust/src/dns/log.rs
> > +index 5212b1a..6bf9589 100644
> > +--- a/rust/src/dns/log.rs
> > ++++ b/rust/src/dns/log.rs
> > +@@ -398,8 +398,8 @@ pub fn dns_print_addr(addr: &Vec<u8>) ->
> > std::string::String {
> > + fn dns_log_soa(soa: &DNSRDataSOA) -> Result<JsonBuilder, JsonError> {
> > +     let mut js = JsonBuilder::try_new_object()?;
> > +
> > +-    js.set_string_from_bytes("mname", &soa.mname)?;
> > +-    js.set_string_from_bytes("rname", &soa.rname)?;
> > ++    js.set_string_from_bytes("mname", &soa.mname.value)?;
> > ++    js.set_string_from_bytes("rname", &soa.rname.value)?;
> > +     js.set_uint("serial", soa.serial as u64)?;
> > +     js.set_uint("refresh", soa.refresh as u64)?;
> > +     js.set_uint("retry", soa.retry as u64)?;
> > +@@ -434,7 +434,7 @@ fn dns_log_srv(srv: &DNSRDataSRV) ->
> > Result<JsonBuilder, JsonError> {
> > +     js.set_uint("priority", srv.priority as u64)?;
> > +     js.set_uint("weight", srv.weight as u64)?;
> > +     js.set_uint("port", srv.port as u64)?;
> > +-    js.set_string_from_bytes("name", &srv.target)?;
> > ++    js.set_string_from_bytes("name", &srv.target.value)?;
> > +
> > +     js.close()?;
> > +     return Ok(js);
> > +@@ -443,7 +443,7 @@ fn dns_log_srv(srv: &DNSRDataSRV) ->
> > Result<JsonBuilder, JsonError> {
> > + fn dns_log_json_answer_detail(answer: &DNSAnswerEntry) ->
> > Result<JsonBuilder, JsonError> {
> > +     let mut jsa = JsonBuilder::try_new_object()?;
> > +
> > +-    jsa.set_string_from_bytes("rrname", &answer.name)?;
> > ++    jsa.set_string_from_bytes("rrname", &answer.name.value)?;
> > +     jsa.set_string("rrtype", &dns_rrtype_string(answer.rrtype))?;
> > +     jsa.set_uint("ttl", answer.ttl as u64)?;
> > +
> > +@@ -451,12 +451,10 @@ fn dns_log_json_answer_detail(answer:
> > &DNSAnswerEntry) -> Result<JsonBuilder, Js
> > +         DNSRData::A(addr) | DNSRData::AAAA(addr) => {
> > +             jsa.set_string("rdata", &dns_print_addr(addr))?;
> > +         }
> > +-        DNSRData::CNAME(bytes)
> > +-        | DNSRData::MX(bytes)
> > +-        | DNSRData::NS(bytes)
> > +-        | DNSRData::TXT(bytes)
> > +-        | DNSRData::NULL(bytes)
> > +-        | DNSRData::PTR(bytes) => {
> > ++        DNSRData::CNAME(name) | DNSRData::MX(name) | DNSRData::NS(name) |
> > DNSRData::PTR(name) => {
> > ++            jsa.set_string_from_bytes("rdata", &name.value)?;
> > ++        }
> > ++        DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
> > +             jsa.set_string_from_bytes("rdata", bytes)?;
> > +         }
> > +         DNSRData::SOA(soa) => {
> > +@@ -507,7 +505,7 @@ fn dns_log_json_answer(
> > +     js.set_uint("opcode", opcode as u64)?;
> > +
> > +     if let Some(query) = response.queries.first() {
> > +-        js.set_string_from_bytes("rrname", &query.name)?;
> > ++        js.set_string_from_bytes("rrname", &query.name.value)?;
> > +         js.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
> > +     }
> > +     js.set_string("rcode", &dns_rcode_string(header.flags))?;
> > +@@ -530,12 +528,19 @@ fn dns_log_json_answer(
> > +                             a.append_string(&dns_print_addr(addr))?;
> > +                         }
> > +                     }
> > +-                    DNSRData::CNAME(bytes)
> > +-                    | DNSRData::MX(bytes)
> > +-                    | DNSRData::NS(bytes)
> > +-                    | DNSRData::TXT(bytes)
> > +-                    | DNSRData::NULL(bytes)
> > +-                    | DNSRData::PTR(bytes) => {
> > ++                    DNSRData::CNAME(name)
> > ++                    | DNSRData::MX(name)
> > ++                    | DNSRData::NS(name)
> > ++                    | DNSRData::PTR(name) => {
> > ++                        if !answer_types.contains_key(&type_string) {
> > ++                            answer_types
> > ++                                .insert(type_string.to_string(),
> > JsonBuilder::try_new_array()?);
> > ++                        }
> > ++                        if let Some(a) =
> > answer_types.get_mut(&type_string) {
> > ++                            a.append_string_from_bytes(&name.value)?;
> > ++                        }
> > ++                    }
> > ++                    DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
> > +                         if !answer_types.contains_key(&type_string) {
> > +                             answer_types.insert(type_string.to_string(),
> > JsonBuilder::try_new_array()?);
> > +                         }
> > +@@ -614,7 +619,7 @@ fn dns_log_query(
> > +             if dns_log_rrtype_enabled(query.rrtype, flags) {
> > +                 jb.set_string("type", "query")?;
> > +                 jb.set_uint("id", request.header.tx_id as u64)?;
> > +-                jb.set_string_from_bytes("rrname", &query.name)?;
> > ++                jb.set_string_from_bytes("rrname", &query.name.value)?;
> > +                 jb.set_string("rrtype",
> > &dns_rrtype_string(query.rrtype))?;
> > +                 jb.set_uint("tx_id", tx.id - 1)?;
> > +                 if request.header.flags & 0x0040 != 0 {
> > +diff --git a/rust/src/dns/lua.rs b/rust/src/dns/lua.rs
> > +index b9935f8..f7b0c15 100644
> > +--- a/rust/src/dns/lua.rs
> > ++++ b/rust/src/dns/lua.rs
> > +@@ -34,12 +34,12 @@ pub extern "C" fn rs_dns_lua_get_rrname(clua: &mut
> > CLuaState, tx: &mut DNSTransa
> > +
> > +     if let Some(request) = &tx.request {
> > +         if let Some(query) = request.queries.first() {
> > +-            lua.pushstring(&String::from_utf8_lossy(&query.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
> > +             return 1;
> > +         }
> > +     } else if let Some(response) = &tx.response {
> > +         if let Some(query) = response.queries.first() {
> > +-            lua.pushstring(&String::from_utf8_lossy(&query.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
> > +             return 1;
> > +         }
> > +     }
> > +@@ -86,7 +86,7 @@ pub extern "C" fn rs_dns_lua_get_query_table(
> > +             lua.settable(-3);
> > +
> > +             lua.pushstring("rrname");
> > +-            lua.pushstring(&String::from_utf8_lossy(&query.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
> > +             lua.settable(-3);
> > +
> > +             lua.settable(-3);
> > +@@ -103,7 +103,7 @@ pub extern "C" fn rs_dns_lua_get_query_table(
> > +             lua.settable(-3);
> > +
> > +             lua.pushstring("rrname");
> > +-            lua.pushstring(&String::from_utf8_lossy(&query.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&query.name.value));
> > +             lua.settable(-3);
> > +
> > +             lua.settable(-3);
> > +@@ -142,11 +142,11 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
> > +             lua.settable(-3);
> > +
> > +             lua.pushstring("rrname");
> > +-            lua.pushstring(&String::from_utf8_lossy(&answer.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&answer.name.value));
> > +             lua.settable(-3);
> > +
> > +             // All rdata types are pushed to "addr" for backwards
> > compatibility
> > +-            match answer.data {
> > ++            match &answer.data {
> > +                 DNSRData::A(ref bytes) | DNSRData::AAAA(ref bytes) => {
> > +                     if !bytes.is_empty() {
> > +                         lua.pushstring("addr");
> > +@@ -154,12 +154,18 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
> > +                         lua.settable(-3);
> > +                     }
> > +                 }
> > +-                DNSRData::CNAME(ref bytes)
> > +-                | DNSRData::MX(ref bytes)
> > +-                | DNSRData::NS(ref bytes)
> > +-                | DNSRData::TXT(ref bytes)
> > ++                DNSRData::CNAME(name)
> > ++                | DNSRData::MX(name)
> > ++                | DNSRData::NS(name)
> > ++                | DNSRData::PTR(name) => {
> > ++                    if !name.value.is_empty() {
> > ++                        lua.pushstring("addr");
> > ++
> > lua.pushstring(&String::from_utf8_lossy(&name.value));
> > ++                        lua.settable(-3);
> > ++                    }
> > ++                }
> > ++                DNSRData::TXT(ref bytes)
> > +                 | DNSRData::NULL(ref bytes)
> > +-                | DNSRData::PTR(ref bytes)
> > +                 | DNSRData::Unknown(ref bytes) => {
> > +                     if !bytes.is_empty() {
> > +                         lua.pushstring("addr");
> > +@@ -168,9 +174,9 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
> > +                     }
> > +                 }
> > +                 DNSRData::SOA(ref soa) => {
> > +-                    if !soa.mname.is_empty() {
> > ++                    if !soa.mname.value.is_empty() {
> > +                         lua.pushstring("addr");
> > +-
> > lua.pushstring(&String::from_utf8_lossy(&soa.mname));
> > ++
> > lua.pushstring(&String::from_utf8_lossy(&soa.mname.value));
> > +                         lua.settable(-3);
> > +                     }
> > +                 }
> > +@@ -181,7 +187,7 @@ pub extern "C" fn rs_dns_lua_get_answer_table(
> > +                 }
> > +                 DNSRData::SRV(ref srv) => {
> > +                     lua.pushstring("addr");
> > +-                    lua.pushstring(&String::from_utf8_lossy(&srv.target));
> > ++
> > lua.pushstring(&String::from_utf8_lossy(&srv.target.value));
> > +                     lua.settable(-3);
> > +                 }
> > +             }
> > +@@ -221,7 +227,7 @@ pub extern "C" fn rs_dns_lua_get_authority_table(
> > +             lua.settable(-3);
> > +
> > +             lua.pushstring("rrname");
> > +-            lua.pushstring(&String::from_utf8_lossy(&answer.name));
> > ++            lua.pushstring(&String::from_utf8_lossy(&answer.name.value));
> > +             lua.settable(-3);
> > +
> > +             lua.settable(-3);
> > +diff --git a/rust/src/dns/parser.rs b/rust/src/dns/parser.rs
> > +index a1d97a5..12929bc 100644
> > +--- a/rust/src/dns/parser.rs
> > ++++ b/rust/src/dns/parser.rs
> > +@@ -45,16 +45,48 @@ pub fn dns_parse_header(i: &[u8]) -> IResult<&[u8],
> > DNSHeader> {
> > +     ))
> > + }
> > +
> > ++// Set a maximum assembled hostname length of 1025, this value was
> > ++// chosen as its what DNSMasq uses, a popular DNS server, even if most
> > ++// tooling limits names to 256 chars without special options.
> > ++static MAX_NAME_LEN: usize = 1025;
> > ++
> > + /// Parse a DNS name.
> > + ///
> > ++/// Names are parsed with the following restrictions:
> > ++///
> > ++/// - Only 255 segments will be processed, if more the parser may
> > ++///   error out. This is also our safeguard against an infinite loop. If
> > ++///   a pointer had been followed a truncated name will be
> > ++///   returned. However if pointer has been processed we error out as we
> > ++///   don't know where the next data point starts without more
> > ++///   iterations.
> > ++///
> > ++/// - The maximum name parsed in representation format is MAX_NAME_LEN
> > ++///   characters. Once larger, the truncated name will be returned with
> > ++///   a flag specifying the name was truncated. Note that parsing
> > ++///   continues if no pointer has been used as we still need to find the
> > ++///   start of the next protocol unit.
> > ++///
> > ++/// As some error in parsing the name are recoverable, a DNSName
> > ++/// object is returned with flags signifying a recoverable
> > ++/// error. These errors include:
> > ++///
> > ++/// - infinite loop: as we know the end of the name in the input
> > ++///   stream, we can return what we've parsed with the remain data.
> > ++///
> > ++/// - maximum number of segments/labels parsed
> > ++///
> > ++/// - truncation of name when too long
> > ++///
> > + /// Parameters:
> > + ///   start: the start of the name
> > + ///   message: the complete message that start is a part of with the DNS
> > header
> > +-pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) ->
> > IResult<&'b [u8], Vec<u8>> {
> > ++pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) ->
> > IResult<&'b [u8], DNSName> {
> > +     let mut pos = start;
> > +     let mut pivot = start;
> > +     let mut name: Vec<u8> = Vec::with_capacity(32);
> > +     let mut count = 0;
> > ++    let mut flags = DNSNameFlags::default();
> > +
> > +     loop {
> > +         if pos.is_empty() {
> > +@@ -68,10 +100,12 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message:
> > &'b [u8]) -> IResult<&'b [u8
> > +             break;
> > +         } else if len & 0b1100_0000 == 0 {
> > +             let (rem, label) = length_data(be_u8)(pos)?;
> > +-            if !name.is_empty() {
> > +-                name.push(b'.');
> > ++            if !flags.contains(DNSNameFlags::TRUNCATED) {
> > ++                if !name.is_empty() {
> > ++                    name.push(b'.');
> > ++                }
> > ++                name.extend(label);
> > +             }
> > +-            name.extend(label);
> > +             pos = rem;
> > +         } else if len & 0b1100_0000 == 0b1100_0000 {
> > +             let (rem, leader) = be_u16(pos)?;
> > +@@ -79,6 +113,21 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b
> > [u8]) -> IResult<&'b [u8
> > +             if offset > message.len() {
> > +                 return Err(Err::Error(error_position!(pos,
> > ErrorKind::OctDigit)));
> > +             }
> > ++
> > ++            if &message[offset..] == pos {
> > ++                // Self reference, immedate infinite loop.
> > ++                flags.insert(DNSNameFlags::INFINITE_LOOP);
> > ++
> > ++                // If we have followed a pointer, we can just break as
> > ++                // we've already found the end of the input. But if we
> > ++                // have not followed a pointer yet return a parse
> > ++                // error.
> > ++                if pivot != start {
> > ++                    break;
> > ++                }
> > ++                return Err(Err::Error(error_position!(pos,
> > ErrorKind::OctDigit)));
> > ++            }
> > ++
> > +             pos = &message[offset..];
> > +             if pivot == start {
> > +                 pivot = rem;
> > +@@ -89,19 +138,43 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message:
> > &'b [u8]) -> IResult<&'b [u8
> > +
> > +         // Return error if we've looped a certain number of times.
> > +         count += 1;
> > ++
> > +         if count > 255 {
> > ++            flags.insert(DNSNameFlags::LABEL_LIMIT);
> > ++
> > ++            // Our segment limit has been reached, if we have hit a
> > ++            // pointer we can just return the truncated name. If we
> > ++            // have not hit a pointer, we need to bail with an error.
> > ++            if pivot != start {
> > ++                flags.insert(DNSNameFlags::TRUNCATED);
> > ++                break;
> > ++            }
> > +             return Err(Err::Error(error_position!(pos,
> > ErrorKind::OctDigit)));
> > +         }
> > ++
> > ++        if name.len() > MAX_NAME_LEN {
> > ++            name.truncate(MAX_NAME_LEN);
> > ++            flags.insert(DNSNameFlags::TRUNCATED);
> > ++
> > ++            // If we have pivoted due to a pointer we know where the
> > ++            // end of the data is, so we can break early. Otherwise
> > ++            // we'll keep parsing in hopes to find the end of the name
> > ++            // so parsing can continue.
> > ++            if pivot != start {
> > ++                break;
> > ++            }
> > ++        }
> > +     }
> > +
> > +     // If we followed a pointer we return the position after the first
> > +     // pointer followed. Is there a better way to see if these slices
> > +     // diverged from each other?  A straight up comparison would
> > +     // actually check the contents.
> > +-    if pivot.len() != start.len() {
> > +-        return Ok((pivot, name));
> > ++    if pivot != start {
> > ++        Ok((pivot, DNSName { value: name, flags }))
> > ++    } else {
> > ++        Ok((pos, DNSName { value: name, flags }))
> > +     }
> > +-    return Ok((pos, name));
> > + }
> > +
> > + /// Parse answer entries.
> > +@@ -121,7 +194,7 @@ fn dns_parse_answer<'a>(
> > +     let mut input = slice;
> > +
> > +     struct Answer<'a> {
> > +-        name: Vec<u8>,
> > ++        name: DNSName,
> > +         rrtype: u16,
> > +         rrclass: u16,
> > +         ttl: u32,
> > +@@ -375,7 +448,7 @@ mod tests {
> > +         ];
> > +         let expected_remainder: &[u8] = &[0x00, 0x01, 0x00];
> > +         let (remainder, name) = dns_parse_name(buf, buf).unwrap();
> > +-        assert_eq!("client-cf.dropbox.com".as_bytes(), &name[..]);
> > ++        assert_eq!("client-cf.dropbox.com".as_bytes(), &name.value[..]);
> > +         assert_eq!(remainder, expected_remainder);
> > +     }
> > +
> > +@@ -411,7 +484,13 @@ mod tests {
> > +         let res1 = dns_parse_name(start1, message);
> > +         assert_eq!(
> > +             res1,
> > +-            Ok((&start1[22..],
> > "www.suricata-ids.org".as_bytes().to_vec()))
> > ++            Ok((
> > ++                &start1[22..],
> > ++                DNSName {
> > ++                    value: "www.suricata-ids.org".as_bytes().to_vec(),
> > ++                    flags: DNSNameFlags::default(),
> > ++                }
> > ++            ))
> > +         );
> > +
> > +         // The second name starts at offset 80, but is just a pointer
> > +@@ -420,7 +499,13 @@ mod tests {
> > +         let res2 = dns_parse_name(start2, message);
> > +         assert_eq!(
> > +             res2,
> > +-            Ok((&start2[2..], "www.suricata-ids.org".as_bytes().to_vec()))
> > ++            Ok((
> > ++                &start2[2..],
> > ++                DNSName {
> > ++                    value: "www.suricata-ids.org".as_bytes().to_vec(),
> > ++                    flags: DNSNameFlags::default()
> > ++                }
> > ++            ))
> > +         );
> > +
> > +         // The third name starts at offset 94, but is a pointer to a
> > +@@ -429,7 +514,13 @@ mod tests {
> > +         let res3 = dns_parse_name(start3, message);
> > +         assert_eq!(
> > +             res3,
> > +-            Ok((&start3[2..], "suricata-ids.org".as_bytes().to_vec()))
> > ++            Ok((
> > ++                &start3[2..],
> > ++                DNSName {
> > ++                    value: "suricata-ids.org".as_bytes().to_vec(),
> > ++                    flags: DNSNameFlags::default()
> > ++                }
> > ++            ))
> > +         );
> > +
> > +         // The fourth name starts at offset 110, but is a pointer to a
> > +@@ -438,7 +529,13 @@ mod tests {
> > +         let res4 = dns_parse_name(start4, message);
> > +         assert_eq!(
> > +             res4,
> > +-            Ok((&start4[2..], "suricata-ids.org".as_bytes().to_vec()))
> > ++            Ok((
> > ++                &start4[2..],
> > ++                DNSName {
> > ++                    value: "suricata-ids.org".as_bytes().to_vec(),
> > ++                    flags: DNSNameFlags::default()
> > ++                }
> > ++            ))
> > +         );
> > +     }
> > +
> > +@@ -473,7 +570,13 @@ mod tests {
> > +         let res = dns_parse_name(start, message);
> > +         assert_eq!(
> > +             res,
> > +-            Ok((&start[2..], "block.g1.dropbox.com".as_bytes().to_vec()))
> > ++            Ok((
> > ++                &start[2..],
> > ++                DNSName {
> > ++                    value: "block.g1.dropbox.com".as_bytes().to_vec(),
> > ++                    flags: DNSNameFlags::default()
> > ++                }
> > ++            ))
> > +         );
> > +     }
> > +
> > +@@ -512,7 +615,7 @@ mod tests {
> > +                 assert_eq!(request.queries.len(), 1);
> > +
> > +                 let query = &request.queries[0];
> > +-                assert_eq!(query.name,
> > "www.suricata-ids.org".as_bytes().to_vec());
> > ++                assert_eq!(query.name.value,
> > "www.suricata-ids.org".as_bytes().to_vec());
> > +                 assert_eq!(query.rrtype, 1);
> > +                 assert_eq!(query.rrclass, 1);
> > +             }
> > +@@ -569,20 +672,26 @@ mod tests {
> > +                 assert_eq!(response.answers.len(), 3);
> > +
> > +                 let answer1 = &response.answers[0];
> > +-                assert_eq!(answer1.name,
> > "www.suricata-ids.org".as_bytes().to_vec());
> > ++                assert_eq!(answer1.name.value,
> > "www.suricata-ids.org".as_bytes().to_vec());
> > +                 assert_eq!(answer1.rrtype, 5);
> > +                 assert_eq!(answer1.rrclass, 1);
> > +                 assert_eq!(answer1.ttl, 3544);
> > +                 assert_eq!(
> > +                     answer1.data,
> > +-
> > DNSRData::CNAME("suricata-ids.org".as_bytes().to_vec())
> > ++                    DNSRData::CNAME(DNSName {
> > ++                        value: "suricata-ids.org".as_bytes().to_vec(),
> > ++                        flags: Default::default(),
> > ++                    })
> > +                 );
> > +
> > +                 let answer2 = &response.answers[1];
> > +                 assert_eq!(
> > +                     answer2,
> > +                     &DNSAnswerEntry {
> > +-                        name: "suricata-ids.org".as_bytes().to_vec(),
> > ++                        name: DNSName {
> > ++                            value: "suricata-ids.org".as_bytes().to_vec(),
> > ++                            flags: Default::default(),
> > ++                        },
> > +                         rrtype: 1,
> > +                         rrclass: 1,
> > +                         ttl: 244,
> > +@@ -594,7 +703,10 @@ mod tests {
> > +                 assert_eq!(
> > +                     answer3,
> > +                     &DNSAnswerEntry {
> > +-                        name: "suricata-ids.org".as_bytes().to_vec(),
> > ++                        name: DNSName {
> > ++                            value: "suricata-ids.org".as_bytes().to_vec(),
> > ++                            flags: Default::default(),
> > ++                        },
> > +                         rrtype: 1,
> > +                         rrclass: 1,
> > +                         ttl: 244,
> > +@@ -653,15 +765,21 @@ mod tests {
> > +                 assert_eq!(response.authorities.len(), 1);
> > +
> > +                 let authority = &response.authorities[0];
> > +-                assert_eq!(authority.name,
> > "oisf.net".as_bytes().to_vec());
> > ++                assert_eq!(authority.name.value,
> > "oisf.net".as_bytes().to_vec());
> > +                 assert_eq!(authority.rrtype, 6);
> > +                 assert_eq!(authority.rrclass, 1);
> > +                 assert_eq!(authority.ttl, 899);
> > +                 assert_eq!(
> > +                     authority.data,
> > +                     DNSRData::SOA(DNSRDataSOA {
> > +-                        mname: "ns-110.awsdns-13.com".as_bytes().to_vec(),
> > +-                        rname:
> > "awsdns-hostmaster.amazon.com".as_bytes().to_vec(),
> > ++                        mname: DNSName {
> > ++                            value:
> > "ns-110.awsdns-13.com".as_bytes().to_vec(),
> > ++                            flags: DNSNameFlags::default()
> > ++                        },
> > ++                        rname: DNSName {
> > ++                            value:
> > "awsdns-hostmaster.amazon.com".as_bytes().to_vec(),
> > ++                            flags: DNSNameFlags::default()
> > ++                        },
> > +                         serial: 1,
> > +                         refresh: 7200,
> > +                         retry: 900,
> > +@@ -712,14 +830,14 @@ mod tests {
> > +
> > +                 assert_eq!(response.queries.len(), 1);
> > +                 let query = &response.queries[0];
> > +-                assert_eq!(query.name,
> > "vaaaakardli.pirate.sea".as_bytes().to_vec());
> > ++                assert_eq!(query.name.value,
> > "vaaaakardli.pirate.sea".as_bytes().to_vec());
> > +                 assert_eq!(query.rrtype, DNS_RECORD_TYPE_NULL);
> > +                 assert_eq!(query.rrclass, 1);
> > +
> > +                 assert_eq!(response.answers.len(), 1);
> > +
> > +                 let answer = &response.answers[0];
> > +-                assert_eq!(answer.name,
> > "vaaaakardli.pirate.sea".as_bytes().to_vec());
> > ++                assert_eq!(answer.name.value,
> > "vaaaakardli.pirate.sea".as_bytes().to_vec());
> > +                 assert_eq!(answer.rrtype, DNS_RECORD_TYPE_NULL);
> > +                 assert_eq!(answer.rrclass, 1);
> > +                 assert_eq!(answer.ttl, 0);
> > +@@ -819,7 +937,7 @@ mod tests {
> > +                         assert_eq!(srv.weight, 1);
> > +                         assert_eq!(srv.port, 5060);
> > +                         assert_eq!(
> > +-                            srv.target,
> > ++                            srv.target.value,
> > +
> > "sip-anycast-2.voice.google.com".as_bytes().to_vec()
> > +                         );
> > +                     }
> > +@@ -834,7 +952,7 @@ mod tests {
> > +                         assert_eq!(srv.weight, 1);
> > +                         assert_eq!(srv.port, 5060);
> > +                         assert_eq!(
> > +-                            srv.target,
> > ++                            srv.target.value,
> > +
> > "sip-anycast-1.voice.google.com".as_bytes().to_vec()
> > +                         );
> > +                     }
> > +@@ -848,4 +966,65 @@ mod tests {
> > +             }
> > +         }
> > +     }
> > ++
> > ++    #[test]
> > ++    fn test_dns_parse_name_truncated() {
> > ++        // Generate a non-compressed hostname over our maximum of 1024.
> > ++        let mut buf: Vec<u8> = vec![];
> > ++        for _ in 0..17 {
> > ++            buf.push(0b0011_1111);
> > ++            for _ in 0..63 {
> > ++                buf.push(b'a');
> > ++            }
> > ++        }
> > ++
> > ++        let (rem, name) = dns_parse_name(&buf, &buf).unwrap();
> > ++        assert_eq!(name.value.len(), MAX_NAME_LEN);
> > ++        assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
> > ++        assert!(rem.is_empty());
> > ++    }
> > ++
> > ++    #[test]
> > ++    fn test_dns_parse_name_truncated_max_segments_no_pointer() {
> > ++        let mut buf: Vec<u8> = vec![];
> > ++        for _ in 0..256 {
> > ++            buf.push(0b0000_0001);
> > ++            buf.push(b'a');
> > ++        }
> > ++
> > ++        // This should fail as we've hit the segment limit without a
> > ++        // pointer, we'd need to keep parsing more segments to figure
> > ++        // out where the next data point lies.
> > ++        assert!(dns_parse_name(&buf, &buf).is_err());
> > ++    }
> > ++
> > ++    #[test]
> > ++    fn test_dns_parse_name_truncated_max_segments_with_pointer() {
> > ++        let mut buf: Vec<u8> = vec![];
> > ++
> > ++        // "a" at the beginning of the buffer.
> > ++        buf.push(0b0000_0001);
> > ++        buf.push(b'a');
> > ++
> > ++        // Followed by a pointer back to the beginning.
> > ++        buf.push(0b1100_0000);
> > ++        buf.push(0b0000_0000);
> > ++
> > ++        // The start of the name, which is pointer to the beginning of
> > ++        // the buffer.
> > ++        buf.push(0b1100_0000);
> > ++        buf.push(0b000_0000);
> > ++
> > ++        let (_rem, name) = dns_parse_name(&buf[4..], &buf).unwrap();
> > ++        assert_eq!(name.value.len(), 255);
> > ++        assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
> > ++    }
> > ++
> > ++    #[test]
> > ++    fn test_dns_parse_name_self_reference() {
> > ++        let mut buf = vec![];
> > ++        buf.push(0b1100_0000);
> > ++        buf.push(0b0000_0000);
> > ++        assert!(dns_parse_name(&buf, &buf).is_err());
> > ++    }
> > + }
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55628-002.patch
> > b/recipes-ids/suricata/files/CVE-2024-55628-002.patch
> > new file mode 100644
> > index 0000000..7bade5d
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55628-002.patch
> > @@ -0,0 +1,4877 @@
> > +From 284ad462fcb2e47f1518a1abc19e27ca84c6972e Mon Sep 17 00:00:00 2001
> > +From: Philippe Antoine<contact@catenacyber.fr>
> > +Date: Thu, 12 May 2022 20:31:25 +0200
> > +Subject: [PATCH] output: adds schema.json
> > +
> > +Ticket: #1369
> > +
> > +CVE: CVE-2024-55628
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/284ad462fcb2e47f1518a1abc19e27ca84c6972e]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + etc/schema.json | 4853 +++++++++++++++++++++++++++++++++++++++++++++++
> > + 1 file changed, 4853 insertions(+)
> > + create mode 100644 etc/schema.json
> > +
> > +diff --git a/etc/schema.json b/etc/schema.json
> > +new file mode 100644
> > +index 0000000..99f419f
> > +--- /dev/null
> > ++++ b/etc/schema.json
> > +@@ -0,0 +1,4853 @@
> > ++{
> > ++    "type": "object",
> > ++    "properties": {
> > ++        "app_proto": {
> > ++            "type": "string",
> > ++            "optional": true
> > ++        },
> > ++        "app_proto_expected": {
> > ++            "type": "string"
> > ++        },
> > ++        "app_proto_orig": {
> > ++            "type": "string"
> > ++        },
> > ++        "app_proto_tc": {
> > ++            "type": "string"
> > ++        },
> > ++        "app_proto_ts": {
> > ++            "type": "string"
> > ++        },
> > ++        "community_id": {
> > ++            "type": "string"
> > ++        },
> > ++        "dest_ip": {
> > ++            "type": "string",
> > ++            "optional": true
> > ++        },
> > ++        "dest_port": {
> > ++            "type": "integer",
> > ++            "optional": true
> > ++        },
> > ++        "event_type": {
> > ++            "type": "string",
> > ++            "optional": false
> > ++        },
> > ++        "flow_id": {
> > ++            "type": "integer",
> > ++            "optional": true
> > ++        },
> > ++        "icmp_code": {
> > ++            "type": "integer"
> > ++        },
> > ++        "icmp_type": {
> > ++            "type": "integer"
> > ++        },
> > ++        "log_level": {
> > ++            "type": "string"
> > ++        },
> > ++        "packet": {
> > ++            "type": "string"
> > ++        },
> > ++        "parent_id": {
> > ++            "type": "integer"
> > ++        },
> > ++        "payload": {
> > ++            "type": "string"
> > ++        },
> > ++        "payload_printable": {
> > ++            "type": "string"
> > ++        },
> > ++        "pcap_cnt": {
> > ++            "type": "integer",
> > ++            "optional": true
> > ++        },
> > ++        "pkt_src": {
> > ++            "type": "string"
> > ++        },
> > ++        "proto": {
> > ++            "type": "string",
> > ++            "optional": true
> > ++        },
> > ++        "response_icmp_code": {
> > ++            "type": "integer"
> > ++        },
> > ++        "response_icmp_type": {
> > ++            "type": "integer"
> > ++        },
> > ++        "spi": {
> > ++            "type": "integer"
> > ++        },
> > ++        "src_ip": {
> > ++            "type": "string",
> > ++            "optional": true
> > ++        },
> > ++        "src_port": {
> > ++            "type": "integer",
> > ++            "optional": true
> > ++        },
> > ++        "stream": {
> > ++            "type": "integer"
> > ++        },
> > ++        "timestamp": {
> > ++            "type": "string",
> > ++            "pattern":
> > "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d+[+\\-]\\d+$",
> > ++            "optional": false
> > ++        },
> > ++        "tx_id": {
> > ++            "type": "integer",
> > ++            "optional": true
> > ++        },
> > ++        "files": {
> > ++            "type": "array",
> > ++            "items": {
> > ++                "type": "object",
> > ++                "optional": true,
> > ++                "properties": {
> > ++                    "end": {
> > ++                        "type": "integer"
> > ++                    },
> > ++                    "filename": {
> > ++                        "type": "string"
> > ++                    },
> > ++                    "gaps": {
> > ++                        "type": "boolean"
> > ++                    },
> > ++                    "md5": {
> > ++                        "type": "string"
> > ++                    },
> > ++                    "sha1": {
> > ++                        "type": "string"
> > ++                    },
> > ++                    "sha256": {
> > ++                        "type": "string"
> > ++                    },
> > ++                    "size": {
> > ++                        "type": "integer"
> > ++                    },
> > ++                    "start": {
> > ++                        "type": "integer"
> > ++                    },
> > ++                    "state": {
> > ++                        "type": "string"
> > ++                    },
> > ++                    "stored": {
> > ++                        "type": "boolean"
> > ++                    },
> > ++                    "tx_id": {
> > ++                        "type": "integer"
> > ++                    },
> > ++                    "sid": {
> > ++                        "type": "array",
> > ++                        "items": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    }
> > ++                },
> > ++                "additionalProperties": false
> > ++            }
> > ++        },
> > ++        "vlan": {
> > ++            "type": "array",
> > ++            "items": {
> > ++                "type": "number"
> > ++            }
> > ++        },
> > ++        "alert": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "action": {
> > ++                    "type": "string"
> > ++                },
> > ++                "category": {
> > ++                    "type": "string"
> > ++                },
> > ++                "gid": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "rev": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "rule": {
> > ++                    "type": "string"
> > ++                },
> > ++                "severity": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "signature": {
> > ++                    "type": "string"
> > ++                },
> > ++                "signature_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "xff": {
> > ++                    "type": "string"
> > ++                },
> > ++                "metadata": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "affected_product": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "attack_target": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "created_at": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "deployment": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "signature_severity": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "tag": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "updated_at": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "source": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "ip": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "target": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "ip": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "anomaly": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "app_proto": {
> > ++                    "type": "string"
> > ++                },
> > ++                "event": {
> > ++                    "type": "string"
> > ++                },
> > ++                "layer": {
> > ++                    "type": "string"
> > ++                },
> > ++                "type": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "dcerpc": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "activityuuid": {
> > ++                    "type": "string"
> > ++                },
> > ++                "call_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "request": {
> > ++                    "type": "string"
> > ++                },
> > ++                "response": {
> > ++                    "type": "string"
> > ++                },
> > ++                "rpc_version": {
> > ++                    "type": "string"
> > ++                },
> > ++                "seqnum": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "interfaces": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "ack_result": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "uuid": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "version": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "req": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "frag_cnt": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "opnum": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "stub_data_size": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "res": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "frag_cnt": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "stub_data_size": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "dhcp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "assigned_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "client_id": {
> > ++                    "type": "string"
> > ++                },
> > ++                "client_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "client_mac": {
> > ++                    "type": "string"
> > ++                },
> > ++                "dhcp_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "hostname": {
> > ++                    "type": "string"
> > ++                },
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "lease_time": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "next_server_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "rebinding_time": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "relay_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "renewal_time": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "subnet_mask": {
> > ++                    "type": "string"
> > ++                },
> > ++                "type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "dns_servers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "params": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "routers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "dnp3": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "dst": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "src": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "application": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "complete": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "function_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "objects": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "object",
> > ++                                "properties": {
> > ++                                    "count": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "group": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "prefix_code": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "qualifier": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "range_code": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "start": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "stop": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "variation": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "points": {
> > ++                                        "type": "array",
> > ++                                        "items": {
> > ++                                            "type": "object",
> > ++                                            "additionalProperties": true
> > ++                                        }
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "control": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "con": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fin": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fir": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "sequence": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "uns": {
> > ++                                    "type": "boolean"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "control": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dir": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "fcb": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "fcv": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "function_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pri": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "iin": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "indicators": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "request": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dst": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "src": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "application": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "complete": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "function_code": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "objects": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "count": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "group": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "prefix_code": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "qualifier": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "range_code": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "start": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "stop": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "variation": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "points": {
> > ++                                                "type": "array",
> > ++                                                "items": {
> > ++                                                    "type": "object",
> > ++
> > "additionalProperties": true
> > ++                                                }
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                },
> > ++                                "control": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "con": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "fin": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "fir": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "sequence": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "uns": {
> > ++                                            "type": "boolean"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "control": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "dir": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fcb": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fcv": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "function_code": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "pri": {
> > ++                                    "type": "boolean"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "response": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dst": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "src": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "application": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "complete": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "function_code": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "objects": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "count": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "group": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "prefix_code": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "qualifier": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "range_code": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "start": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "stop": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "variation": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "points": {
> > ++                                                "type": "array",
> > ++                                                "items": {
> > ++                                                    "type": "object",
> > ++
> > "additionalProperties": true
> > ++                                                }
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                },
> > ++                                "control": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "con": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "fin": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "fir": {
> > ++                                            "type": "boolean"
> > ++                                        },
> > ++                                        "sequence": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "uns": {
> > ++                                            "type": "boolean"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "control": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "dir": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fcb": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "fcv": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "function_code": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "pri": {
> > ++                                    "type": "boolean"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "iin": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "indicators": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "string"
> > ++                                    }
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "dns": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "aa": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "flags": {
> > ++                    "type": "string"
> > ++                },
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "qr": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "ra": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "rcode": {
> > ++                    "type": "string"
> > ++                },
> > ++                "rd": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "rrname": {
> > ++                    "type": "string"
> > ++                },
> > ++                "rrtype": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tx_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "answers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "optional": true,
> > ++                        "properties": {
> > ++                            "rdata": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "rrname": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "rrtype": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "ttl": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "srv": {
> > ++                                "type": "object",
> > ++                                "optional": true,
> > ++                                "properties": {
> > ++                                    "name": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "port": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "priority": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "weight": {
> > ++                                        "type": "integer"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "authorities": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "optional": true,
> > ++                        "properties": {
> > ++                            "rdata": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "rrname": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "rrtype": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "ttl": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "soa": {
> > ++                                "type": "object",
> > ++                                "optional": true,
> > ++                                "properties": {
> > ++                                    "expire": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "minimum": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "mname": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "refresh": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "retry": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "rname": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "serial": {
> > ++                                        "type": "integer"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "query": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "optional": true,
> > ++                        "properties": {
> > ++                            "id": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "rrname": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "rrtype": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "tx_id": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "type": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "z": {
> > ++                                "type": "boolean"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "answer": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "flags": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qr": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "ra": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "rcode": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "rd": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "rrname": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "rrtype": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "version": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "grouped": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "A": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "AAAA": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "CNAME": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "MX": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "NULL": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "PTR": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "SRV": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "object",
> > ++                                "optional": true,
> > ++                                "properties": {
> > ++                                    "name": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "port": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "priority": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "weight": {
> > ++                                        "type": "integer"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "TXT": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "z": {
> > ++                    "type": "boolean"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "drop": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "ack": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "fin": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "icmp_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "icmp_seq": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "ipid": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "len": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "psh": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "rst": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "syn": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "tcpack": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "tcpres": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "tcpseq": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "tcpurgp": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "tcpwin": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "tos": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "ttl": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "urg": {
> > ++                    "type": "boolean"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "email": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "body_md5": {
> > ++                    "type": "string"
> > ++                },
> > ++                "from": {
> > ++                    "type": "string"
> > ++                },
> > ++                "status": {
> > ++                    "type": "string"
> > ++                },
> > ++                "subject": {
> > ++                    "type": "string"
> > ++                },
> > ++                "subject_md5": {
> > ++                    "type": "string"
> > ++                },
> > ++                "url": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "attachment": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "to": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "engine": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "error": {
> > ++                    "type": "string"
> > ++                },
> > ++                "error_code": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "message": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "ether": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "dest_mac": {
> > ++                    "type": "string"
> > ++                },
> > ++                "src_mac": {
> > ++                    "type": "string"
> > ++                },
> > ++                "dest_macs": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "src_macs": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "fileinfo": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "end": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "file_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "filename": {
> > ++                    "type": "string"
> > ++                },
> > ++                "gaps": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "magic": {
> > ++                    "type": "string"
> > ++                },
> > ++                "md5": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sha1": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sha256": {
> > ++                    "type": "string"
> > ++                },
> > ++                "size": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "start": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "state": {
> > ++                    "type": "string"
> > ++                },
> > ++                "stored": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "tx_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "sid": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "integer"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "flow": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "action": {
> > ++                    "type": "string"
> > ++                },
> > ++                "age": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "alerted": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "bypass": {
> > ++                    "type": "string"
> > ++                },
> > ++                "bypassed": {
> > ++                    "type": "object",
> > ++                    "optional": false,
> > ++                    "properties": {
> > ++                        "pkts_toserver": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pkts_toclient": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "bytes_toserver": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "bytes_toclient": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperites": false
> > ++                },
> > ++                "bytes_toclient": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "bytes_toserver": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "end": {
> > ++                    "type": "string"
> > ++                },
> > ++                "pkts_toclient": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "pkts_toserver": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "reason": {
> > ++                    "type": "string"
> > ++                },
> > ++                "start": {
> > ++                    "type": "string"
> > ++                },
> > ++                "state": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "frame": {
> > ++            "type": "object",
> > ++            "properties": {
> > ++                "type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "direction": {
> > ++                    "type": "string"
> > ++                },
> > ++                "stream_offset": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "length": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "complete": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "payload": {
> > ++                    "type": "string"
> > ++                },
> > ++                "payload_printable": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tx_id": {
> > ++                    "type": "integer"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "ftp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "command": {
> > ++                    "type": "string"
> > ++                },
> > ++                "command_data": {
> > ++                    "type": "string"
> > ++                },
> > ++                "command_truncated": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "dynamic_port": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "mode": {
> > ++                    "type": "string"
> > ++                },
> > ++                "reply_received": {
> > ++                    "type": "string"
> > ++                },
> > ++                "reply_truncated": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "completion_code": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "reply": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "ftp_data": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "command": {
> > ++                    "type": "string"
> > ++                },
> > ++                "filename": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "http": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "hostname": {
> > ++                    "type": "string"
> > ++                },
> > ++                "http_content_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "http_method": {
> > ++                    "type": "string"
> > ++                },
> > ++                "http_port": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "http_refer": {
> > ++                    "type": "string"
> > ++                },
> > ++                "http_user_agent": {
> > ++                    "type": "string"
> > ++                },
> > ++                "length": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "protocol": {
> > ++                    "type": "string"
> > ++                },
> > ++                "redirect": {
> > ++                    "type": "string"
> > ++                },
> > ++                "status": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "url": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "string"
> > ++                },
> > ++                "xff": {
> > ++                    "type": "string"
> > ++                },
> > ++                "request_headers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "name": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "table_size_update": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "value": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "response_headers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "name": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "table_size_update": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "value": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "content_range": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "end": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "raw": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "size": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "start": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "http2": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "stream_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "request": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "error_code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "priority": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "settings": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "settings_id": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "settings_value": {
> > ++                                                "type": "integer"
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "response": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "error_code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "settings": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "settings_id": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "settings_value": {
> > ++                                                "type": "integer"
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "http2": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "http_method": {
> > ++                    "type": "string"
> > ++                },
> > ++                "http_user_agent": {
> > ++                    "type": "string"
> > ++                },
> > ++                "length": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "status": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "url": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "string"
> > ++                },
> > ++                "request_headers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "name": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "table_size_update": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "value": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "response_headers": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "name": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "table_size_update": {
> > ++                                "type": "integer"
> > ++                            },
> > ++                            "value": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "http2": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "stream_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "request": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "priority": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "response": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "error_code": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "ike": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "alg_auth": {
> > ++                    "type": "string"
> > ++                },
> > ++                "alg_auth_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "alg_dh": {
> > ++                    "type": "string"
> > ++                },
> > ++                "alg_dh_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "alg_enc": {
> > ++                    "type": "string"
> > ++                },
> > ++                "alg_enc_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "alg_hash": {
> > ++                    "type": "string"
> > ++                },
> > ++                "alg_hash_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "exchange_type": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "exchange_type_verbose": {
> > ++                    "type": "string"
> > ++                },
> > ++                "init_spi": {
> > ++                    "type": "string"
> > ++                },
> > ++                "message_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "resp_spi": {
> > ++                    "type": "string"
> > ++                },
> > ++                "role": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sa_key_length": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sa_key_length_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "sa_life_duration": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sa_life_duration_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "sa_life_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sa_life_type_raw": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "version_major": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "version_minor": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "payload": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "ikev1": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "doi": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "encrypted_payloads": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "vendor_ids": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "client": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "key_exchange_payload": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "key_exchange_payload_length": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nonce_payload": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "nonce_payload_length": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "proposals": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "alg_auth": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "alg_auth_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "alg_dh": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "alg_dh_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "alg_enc": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "alg_enc_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "alg_hash": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "alg_hash_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "sa_key_length": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "sa_key_length_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "sa_life_duration": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "sa_life_duration_raw": {
> > ++                                                "type": "integer"
> > ++                                            },
> > ++                                            "sa_life_type": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "sa_life_type_raw": {
> > ++                                                "type": "integer"
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "server": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "key_exchange_payload": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "key_exchange_payload_length": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nonce_payload": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "nonce_payload_length": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "ikev2": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "errors": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "notify": {
> > ++                            "type": "array"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "krb5": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "cname": {
> > ++                    "type": "string"
> > ++                },
> > ++                "encryption": {
> > ++                    "type": "string"
> > ++                },
> > ++                "error_code": {
> > ++                    "type": "string"
> > ++                },
> > ++                "failed_request": {
> > ++                    "type": "string"
> > ++                },
> > ++                "msg_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "realm": {
> > ++                    "type": "string"
> > ++                },
> > ++                "sname": {
> > ++                    "type": "string"
> > ++                },
> > ++                "weak_encryption": {
> > ++                    "type": "boolean"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "metadata": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "flowbits": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "flowvars": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "gid": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "key": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "value": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": true
> > ++                    }
> > ++                },
> > ++                "pktvars": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "uid": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "username": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        },
> > ++                        "additionalProperties": false
> > ++                    }
> > ++                },
> > ++                "flowints": {
> > ++                    "type": "object",
> > ++                    "additionalProperties": true
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "modbus": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "request": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "access_type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "category": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "data": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "error_flags": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "function_code": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "function_raw": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "protocol_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "transaction_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "unit_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "diagnostic": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "data": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "raw": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "mei": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "data": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "raw": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "read": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "address": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "quantity": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "write": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "address": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "data": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "response": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "access_type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "category": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "data": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "error_flags": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "function_code": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "function_raw": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "protocol_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "transaction_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "unit_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "diagnostic": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "data": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "raw": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "exception": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "code": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "raw": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "read": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "data": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "write": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "address": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "data": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "mqtt": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "connack": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "return_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "session_present": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "properties": {
> > ++                            "type": "object",
> > ++                            "additionalProperties": true
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "connect": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "client_id": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "password": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "protocol_string": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "protocol_version": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "username": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "flags": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "clean_session": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "password": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "username": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "will": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "will_retain": {
> > ++                                    "type": "boolean"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "properties": {
> > ++                            "type": "object",
> > ++                            "additionalProperties": true
> > ++                        },
> > ++                        "will": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "message": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "topic": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "properties": {
> > ++                                    "type": "object",
> > ++                                    "additionalProperties": true
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "disconnect": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reason_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "properties": {
> > ++                            "type": "object",
> > ++                            "additionalProperties": true
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "pingreq": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "pingresp": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "puback": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reason_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "pubcomp": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reason_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "publish": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "skipped_length": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "topic": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "truncated": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "properties": {
> > ++                            "type": "object",
> > ++                            "additionalProperties": true
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "pubrec": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reason_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "pubrel": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reason_code": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "suback": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "qos_granted": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "integer"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "subscribe": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "topics": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "object",
> > ++                                "properties": {
> > ++                                    "qos": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "topic": {
> > ++                                        "type": "string"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "unsuback": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "reason_codes": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "integer"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "unsubscribe": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "dup": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "message_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "qos": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "retain": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "topics": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "netflow": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "age": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "bytes": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "end": {
> > ++                    "type": "string"
> > ++                },
> > ++                "max_ttl": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "min_ttl": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "pkts": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "start": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "nfs": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "file_tx": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "filename": {
> > ++                    "type": "string"
> > ++                },
> > ++                "hhash": {
> > ++                    "type": "string"
> > ++                },
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "procedure": {
> > ++                    "type": "string"
> > ++                },
> > ++                "status": {
> > ++                    "type": "string"
> > ++                },
> > ++                "type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "read": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "chunks": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "first": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "last": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "last_xid": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "rename": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "from": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "to": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "write": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "chunks": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "first": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "last": {
> > ++                            "type": "boolean"
> > ++                        },
> > ++                        "last_xid": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "packet_info": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "linktype": {
> > ++                    "type": "integer"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "pgsql": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "request": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "message": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "password": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "password_message": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "protocol_version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "sasl_authentication_mechanism": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "sasl_param": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "sasl_response": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "simple_query": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "startup_parameters": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "database": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "optional_parameters": {
> > ++                                    "type": "array",
> > ++                                    "items": {
> > ++                                        "type": "object",
> > ++                                        "properties": {
> > ++                                            "application_name": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "client_encoding": {
> > ++                                                "type": "string"
> > ++                                            },
> > ++                                            "replication": {
> > ++                                                "type": "string"
> > ++                                            }
> > ++                                        },
> > ++                                        "additionalProperties": false
> > ++                                    }
> > ++                                },
> > ++                                "user": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "response": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "authentication_md5_password": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "authentication_sasl_final": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "code": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "command_completed": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "data_rows": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "data_size": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "field_count": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "file": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "line": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "message": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "parameter_status": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "object",
> > ++                                "properties": {
> > ++                                    "application_name": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "client_encoding": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "date_style": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "integer_datetimes": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "interval_style": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "is_superuser": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "server_encoding": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "server_version": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "session_authorization": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "standard_conforming_strings": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "time_zone": {
> > ++                                        "type": "string"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "process_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "routine": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "secret_key": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "severity_localizable": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "severity_non_localizable": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "ssl_accepted": {
> > ++                            "type": "boolean"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "tx_id": {
> > ++                    "type": "integer"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "quic": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "cyu": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "object",
> > ++                        "properties": {
> > ++                            "hash": {
> > ++                                "type": "string"
> > ++                            },
> > ++                            "string": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "sni": {
> > ++                    "type": "string"
> > ++                },
> > ++                "ua": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "rdp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "cookie": {
> > ++                    "type": "string"
> > ++                },
> > ++                "event_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tx_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "channels": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "client": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "build": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "client_name": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "color_depth": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "desktop_height": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "desktop_width": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "function_keys": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "id": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "keyboard_layout": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "keyboard_type": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "product_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "capabilities": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "rfb": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "screen_shared": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "authentication": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "security_result": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "security_type": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "vnc": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "challenge": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "response": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "client_protocol_version": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "major": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "minor": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "framebuffer": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "height": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "name": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "width": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pixel_format": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "big_endian": {
> > ++                                    "type": "boolean"
> > ++                                },
> > ++                                "bits_per_pixel": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "blue_max": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "blue_shift": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "depth": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "green_max": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "green_shift": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "red_max": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "red_shift": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "true_color": {
> > ++                                    "type": "boolean"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "server_protocol_version": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "major": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "minor": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "rpc": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "auth_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "status": {
> > ++                    "type": "string"
> > ++                },
> > ++                "xid": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "creds": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "gid": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "machine_name": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "uid": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "sip": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "code": {
> > ++                    "type": "string"
> > ++                },
> > ++                "method": {
> > ++                    "type": "string"
> > ++                },
> > ++                "reason": {
> > ++                    "type": "string"
> > ++                },
> > ++                "request_line": {
> > ++                    "type": "string"
> > ++                },
> > ++                "response_line": {
> > ++                    "type": "string"
> > ++                },
> > ++                "uri": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "smb": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "access": {
> > ++                    "type": "string"
> > ++                },
> > ++                "accessed": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "changed": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "client_guid": {
> > ++                    "type": "string"
> > ++                },
> > ++                "command": {
> > ++                    "type": "string"
> > ++                },
> > ++                "created": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "dialect": {
> > ++                    "type": "string"
> > ++                },
> > ++                "directory": {
> > ++                    "type": "string"
> > ++                },
> > ++                "disposition": {
> > ++                    "type": "string"
> > ++                },
> > ++                "filename": {
> > ++                    "type": "string"
> > ++                },
> > ++                "fuid": {
> > ++                    "type": "string"
> > ++                },
> > ++                "function": {
> > ++                    "type": "string"
> > ++                },
> > ++                "id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "max_read_size": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "max_write_size": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "modified": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "named_pipe": {
> > ++                    "type": "string"
> > ++                },
> > ++                "request_done": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "response_done": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "server_guid": {
> > ++                    "type": "string"
> > ++                },
> > ++                "session_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "share": {
> > ++                    "type": "string"
> > ++                },
> > ++                "share_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "size": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "status": {
> > ++                    "type": "string"
> > ++                },
> > ++                "status_code": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tree_id": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "client_dialects": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "dcerpc": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "call_id": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "opnum": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "request": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "response": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "interfaces": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "object",
> > ++                                "optional": true,
> > ++                                "properties": {
> > ++                                    "ack_reason": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "ack_result": {
> > ++                                        "type": "integer"
> > ++                                    },
> > ++                                    "uuid": {
> > ++                                        "type": "string"
> > ++                                    },
> > ++                                    "version": {
> > ++                                        "type": "string"
> > ++                                    }
> > ++                                },
> > ++                                "additionalProperties": false
> > ++                            }
> > ++                        },
> > ++                        "req": {
> > ++                            "type": "object",
> > ++                            "optional": true,
> > ++                            "properties": {
> > ++                                "frag_cnt": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "stub_data_size": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "res": {
> > ++                            "type": "object",
> > ++                            "optional": true,
> > ++                            "properties": {
> > ++                                "frag_cnt": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "stub_data_size": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "kerberos": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "realm": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "snames": {
> > ++                            "type": "array",
> > ++                            "items": {
> > ++                                "type": "string"
> > ++                            }
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "ntlmssp": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "domain": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "host": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "user": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "request": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "native_lm": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "native_os": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "response": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "native_lm": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "native_os": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "service": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "request": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "response": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "smtp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "helo": {
> > ++                    "type": "string"
> > ++                },
> > ++                "mail_from": {
> > ++                    "type": "string"
> > ++                },
> > ++                "rcpt_to": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "snmp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "community": {
> > ++                    "type": "string"
> > ++                },
> > ++                "pdu_type": {
> > ++                    "type": "string"
> > ++                },
> > ++                "usm": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "vars": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "ssh": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "client": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "proto_version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "software_version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "hassh": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "hash": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "string": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "server": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "proto_version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "software_version": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "hassh": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "hash": {
> > ++                                    "type": "string"
> > ++                                },
> > ++                                "string": {
> > ++                                    "type": "string"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "stats": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "uptime": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "app_layer": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "expectations": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "error": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "dcerpc_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "dcerpc_udp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "dhcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "dnp3": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "dns_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "dns_udp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "enip_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "enip_udp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "failed_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "ftp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "ftp-data": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "http": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "http2": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "ike": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "imap": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "krb5_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "krb5_udp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "mqtt": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "nfs_tcp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "nfs_udp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "ntp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "pgsql": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "quic": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "rdp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "rfb": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "sip": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "smb": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "smtp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "snmp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "ssh": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "telnet": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "tftp": { "$ref":
> > "#/$defs/stats_applayer_error" },
> > ++                                "tls": { "$ref":
> > "#/$defs/stats_applayer_error" }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "flow": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "dcerpc_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dcerpc_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dhcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dnp3": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dns_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dns_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "enip_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "enip_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "failed_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "failed_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ftp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ftp-data": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "http": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "http2": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ike": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ikev2": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "imap": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "krb5_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "krb5_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "modbus": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "mqtt": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nfs_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nfs_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ntp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "pgsql": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "quic": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "rdp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "rfb": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "sip": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "smb": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "smtp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "snmp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ssh": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "telnet": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "tftp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "tls": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "tx": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "dcerpc_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dcerpc_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dhcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dnp3": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dns_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "dns_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "enip_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "enip_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ftp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ftp-data": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "http": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "http2": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ike": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ikev2": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "imap": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "krb5_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "krb5_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "modbus": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "mqtt": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nfs_tcp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "nfs_udp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ntp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "pgsql": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "quic": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "rdp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "rfb": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "sip": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "smb": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "smtp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "snmp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "ssh": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "telnet": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "tftp": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "tls": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "decoder": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "avg_pkt_size": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "bytes": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "chdlc": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "erspan": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "esp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ethernet": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "geneve": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "gre": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "icmpv4": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "icmpv6": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ieee8021ah": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "invalid": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ipv4": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ipv4_in_ipv6": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ipv6": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ipv6_in_ipv6": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "max_mac_addrs_dst": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "max_mac_addrs_src": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "max_pkt_size": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "mpls": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "nsh": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "null": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pkts": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ppp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pppoe": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "raw": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "sctp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "sll": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "tcp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "teredo": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "too_many_layers": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "udp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "vlan": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "vlan_qinq": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "vntag": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "vxlan": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "event": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "chdlc": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "dce": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "erspan": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "too_many_vlan_layers": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unsupported_version": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "esp": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ethernet": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "geneve": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "unknown_payload_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "gre": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version0_flags": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version0_hdr_too_big": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version0_malformed_sre_hdr": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version0_recur": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_chksum": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_flags": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_hdr_too_big": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_malformed_sre_hdr": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_no_key": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_recur": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_route": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_ssr": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "version1_wrong_protocol": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "wrong_version": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "icmpv4": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "ipv4_trunc_pkt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv4_unknown_ver": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_code": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "icmpv6": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "experimentation_type": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv6_trunc_pkt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv6_unknown_version": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "mld_message_with_invalid_hl": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unassigned_type": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_code": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ieee8021ah": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ipraw": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "invalid_ip_version": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ipv4": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "frag_ignored": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_overlap": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_pkt_too_large": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "hlen_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "icmpv6": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "iplen_smaller_than_hlen": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_duplicate": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_eol_required": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_invalid": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_invalid_len": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_malformed": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_pad_required": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_unknown": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "trunc_pkt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "wrong_ip_version": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ipv6": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "data_after_none_header": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "dstopts_only_padding": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "dstopts_unknown_opt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_ah_res_not_null": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_ah": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_dh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_eh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_fh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_hh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_dupl_rh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_invalid_optlen": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "exthdr_useless_fh": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "fh_non_zero_reserved_field": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_ignored": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_invalid_length": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_overlap": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "frag_pkt_too_large": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "hopopts_only_padding": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "hopopts_unknown_opt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "icmpv4": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv4_in_ipv6_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv4_in_ipv6_wrong_version": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv6_in_ipv6_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ipv6_in_ipv6_wrong_version": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "rh_type_0": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "trunc_exthdr": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "trunc_pkt": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_next_header": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "wrong_ip_version": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "zero_len_padn": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ltnull": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unsupported_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "mpls": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "bad_label_implicit_null": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "bad_label_reserved": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "bad_label_router_alert": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_payload_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "nsh": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "bad_header_length": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "reserved_type": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_payload": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unsupported_type": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unsupported_version": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "ppp": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "ip4_pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "ip6_pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unsup_proto": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "vju_pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "wrong_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "pppoe": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "malformed_tags": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "wrong_code": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "sctp": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "sll": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "tcp": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "hlen_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "invalid_optlen": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_duplicate": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "opt_invalid_len": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "udp": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "hlen_invalid": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "hlen_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "pkt_too_small": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "vlan": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "too_many_layers": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "vntag": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "header_too_small": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "unknown_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                },
> > ++                                "vxlan": {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "unknown_payload_type": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "defrag": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "max_frag_hits": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ipv4": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "fragments": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "reassembled": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "timeouts": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "ipv6": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "fragments": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "reassembled": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "timeouts": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "detect": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "alert": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "alert_queue_overflow": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "alerts_suppressed": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "engines": {
> > ++                            "type": "array",
> > ++                            "items": [
> > ++                                {
> > ++                                    "type": "object",
> > ++                                    "properties": {
> > ++                                        "id": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "last_reload": {
> > ++                                            "type": "string"
> > ++                                        },
> > ++                                        "rules_loaded": {
> > ++                                            "type": "integer"
> > ++                                        },
> > ++                                        "rules_failed": {
> > ++                                            "type": "integer"
> > ++                                        }
> > ++                                    },
> > ++                                    "additionalProperties": false
> > ++                                }
> > ++                            ]
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "file_store": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "fs_errors": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "open_files": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "open_files_max_hit": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "flow": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "emerg_mode_entered": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "emerg_mode_over": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "get_used": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "get_used_eval": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "get_used_eval_busy": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "get_used_eval_reject": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "get_used_failed": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "icmpv4": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "icmpv6": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "memcap": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "memuse": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "spare": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "tcp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "tcp_reuse": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "udp": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "mgr": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "bypassed_pruned": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "closed_pruned": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "est_pruned": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_checked": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_evicted": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_evicted_needs_work": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_notimeout": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_timeout": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_timeout_inuse": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "full_hash_pass": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "new_pruned": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "rows_maxlen": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        },
> > ++                        "wrk": {
> > ++                            "type": "object",
> > ++                            "properties": {
> > ++                                "flows_evicted": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_evicted_needs_work": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_evicted_pkt_inject": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "flows_injected": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "spare_sync": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "spare_sync_avg": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "spare_sync_empty": {
> > ++                                    "type": "integer"
> > ++                                },
> > ++                                "spare_sync_incomplete": {
> > ++                                    "type": "integer"
> > ++                                }
> > ++                            },
> > ++                            "additionalProperties": false
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "flow_bypassed": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "bytes": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "closed": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "local_bytes": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "local_capture_bytes": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "local_capture_pkts": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "local_pkts": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pkts": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "flow_mgr": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "bypassed_pruned": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "closed_pruned": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "est_pruned": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "flows_checked": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "flows_notimeout": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "flows_removed": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "flows_timeout": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "flows_timeout_inuse": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "new_pruned": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rows_busy": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rows_checked": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rows_empty": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rows_maxlen": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rows_skipped": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "ftp": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "memcap": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "memuse": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "http": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "memcap": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "memuse": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "tcp": {
> > ++                    "type": "object",
> > ++                    "properties": {
> > ++                        "insert_data_normal_fail": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "insert_data_overlap_fail": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "insert_list_fail": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "invalid_checksum": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "memuse": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "midstream_pickups": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "no_flow": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "overlap": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "overlap_diff_data": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pkt_on_wrong_thread": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pseudo": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "pseudo_failed": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reassembly_gap": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "reassembly_memuse": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "rst": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "segment_memcap_drop": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "sessions": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "ssn_memcap_drop": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "stream_depth_reached": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "syn": {
> > ++                            "type": "integer"
> > ++                        },
> > ++                        "synack": {
> > ++                            "type": "integer"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "tcp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "ack": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "cwr": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "ecn": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "fin": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "psh": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "rst": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "state": {
> > ++                    "type": "string"
> > ++                },
> > ++                "syn": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "tcp_flags": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tcp_flags_tc": {
> > ++                    "type": "string"
> > ++                },
> > ++                "tcp_flags_ts": {
> > ++                    "type": "string"
> > ++                },
> > ++                "urg": {
> > ++                    "type": "boolean"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "template": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "request": {
> > ++                    "type": "string"
> > ++                },
> > ++                "response": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "tftp": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "file": {
> > ++                    "type": "string"
> > ++                },
> > ++                "mode": {
> > ++                    "type": "string"
> > ++                },
> > ++                "packet": {
> > ++                    "type": "string"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "tls": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "fingerprint": {
> > ++                    "type": "string"
> > ++                },
> > ++                "from_proto": {
> > ++                    "type": "string"
> > ++                },
> > ++                "issuerdn": {
> > ++                    "type": "string"
> > ++                },
> > ++                "notafter": {
> > ++                    "type": "string"
> > ++                },
> > ++                "notbefore": {
> > ++                    "type": "string"
> > ++                },
> > ++                "serial": {
> > ++                    "type": "string"
> > ++                },
> > ++                "session_resumed": {
> > ++                    "type": "boolean"
> > ++                },
> > ++                "sni": {
> > ++                    "type": "string"
> > ++                },
> > ++                "subject": {
> > ++                    "type": "string"
> > ++                },
> > ++                "version": {
> > ++                    "type": "string"
> > ++                },
> > ++                "ja3": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "hash": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "string": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                },
> > ++                "ja3s": {
> > ++                    "type": "object",
> > ++                    "optional": true,
> > ++                    "properties": {
> > ++                        "hash": {
> > ++                            "type": "string"
> > ++                        },
> > ++                        "string": {
> > ++                            "type": "string"
> > ++                        }
> > ++                    },
> > ++                    "additionalProperties": false
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "traffic": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "id": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                },
> > ++                "label": {
> > ++                    "type": "array",
> > ++                    "items": {
> > ++                        "type": "string"
> > ++                    }
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        },
> > ++        "tunnel": {
> > ++            "type": "object",
> > ++            "optional": true,
> > ++            "properties": {
> > ++                "depth": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "dest_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "dest_port": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "pcap_cnt": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "pkt_src": {
> > ++                    "type": "string"
> > ++                },
> > ++                "proto": {
> > ++                    "type": "string"
> > ++                },
> > ++                "src_ip": {
> > ++                    "type": "string"
> > ++                },
> > ++                "src_port": {
> > ++                    "type": "integer"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        }
> > ++    },
> > ++    "additionalProperties": false,
> > ++    "$defs": {
> > ++        "stats_applayer_error": {
> > ++            "type": "object",
> > ++            "properties": {
> > ++                "gap": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "alloc": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "parser": {
> > ++                    "type": "integer"
> > ++                },
> > ++                "internal": {
> > ++                    "type": "integer"
> > ++                }
> > ++            },
> > ++            "additionalProperties": false
> > ++        }
> > ++    }
> > ++}
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55628-003.patch
> > b/recipes-ids/suricata/files/CVE-2024-55628-003.patch
> > new file mode 100644
> > index 0000000..c498a6b
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55628-003.patch
> > @@ -0,0 +1,114 @@
> > +From 5edb84fe234f47a0fedfbf9b10b49699152fe8cb Mon Sep 17 00:00:00 2001
> > +From: Jason Ish<jason.ish@oisf.net>
> > +Date: Thu, 31 Oct 2024 15:46:35 -0600
> > +Subject: [PATCH] eve/dns: add truncation flags for fields that are
> > truncated
> > +
> > +If rrname, rdata or mname are truncated, set a flag field like
> > +'rrname_truncated: true' to indicate that the name is truncated.
> > +
> > +Ticket: #7280
> > +
> > +(cherry picked from commit 37f4c52b22fcdde4adf9b479cb5700f89d00768d)
> > +
> > +CVE: CVE-2024-55628
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/5edb84fe234f47a0fedfbf9b10b49699152fe8cb]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + etc/schema.json     |  7 +++++++
> > + rust/src/dns/log.rs | 19 +++++++++++++++++++
> > + 2 files changed, 26 insertions(+)
> > +
> > +diff --git a/etc/schema.json b/etc/schema.json
> > +index 99f419f..422d77c 100644
> > +--- a/etc/schema.json
> > ++++ b/etc/schema.json
> > +@@ -790,6 +790,9 @@
> > +                 "rrname": {
> > +                     "type": "string"
> > +                 },
> > ++		"rrname_truncated": {
> > ++		    "type": "boolean"
> > ++		},
> > +                 "rrtype": {
> > +                     "type": "string"
> > +                 },
> > +@@ -2365,6 +2368,10 @@
> > +                             "type": "array",
> > +                             "items": {
> > +                                 "type": "integer"
> > ++                            },
> > ++                            "rrname_truncated": {
> > ++                                "description": "Set to true if the rrname
> > was too long and truncated by Suricata",
> > ++                                "type": "boolean"
> > +                             }
> > +                         }
> > +                     },
> > +diff --git a/rust/src/dns/log.rs b/rust/src/dns/log.rs
> > +index 6bf9589..d0e468d 100644
> > +--- a/rust/src/dns/log.rs
> > ++++ b/rust/src/dns/log.rs
> > +@@ -399,7 +399,13 @@ fn dns_log_soa(soa: &DNSRDataSOA) ->
> > Result<JsonBuilder, JsonError> {
> > +     let mut js = JsonBuilder::try_new_object()?;
> > +
> > +     js.set_string_from_bytes("mname", &soa.mname.value)?;
> > ++    if soa.mname.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++        js.set_bool("mname_truncated", true)?;
> > ++    }
> > +     js.set_string_from_bytes("rname", &soa.rname.value)?;
> > ++    if soa.rname.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++        js.set_bool("rname_truncated", true)?;
> > ++    }
> > +     js.set_uint("serial", soa.serial as u64)?;
> > +     js.set_uint("refresh", soa.refresh as u64)?;
> > +     js.set_uint("retry", soa.retry as u64)?;
> > +@@ -444,6 +450,9 @@ fn dns_log_json_answer_detail(answer: &DNSAnswerEntry)
> > -> Result<JsonBuilder, Js
> > +     let mut jsa = JsonBuilder::try_new_object()?;
> > +
> > +     jsa.set_string_from_bytes("rrname", &answer.name.value)?;
> > ++    if answer.name.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++        jsa.set_bool("rrname_truncated", true)?;
> > ++    }
> > +     jsa.set_string("rrtype", &dns_rrtype_string(answer.rrtype))?;
> > +     jsa.set_uint("ttl", answer.ttl as u64)?;
> > +
> > +@@ -453,6 +462,9 @@ fn dns_log_json_answer_detail(answer: &DNSAnswerEntry)
> > -> Result<JsonBuilder, Js
> > +         }
> > +         DNSRData::CNAME(name) | DNSRData::MX(name) | DNSRData::NS(name) |
> > DNSRData::PTR(name) => {
> > +             jsa.set_string_from_bytes("rdata", &name.value)?;
> > ++            if name.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++                jsa.set_bool("rdata_truncated", true)?;
> > ++            }
> > +         }
> > +         DNSRData::TXT(bytes) | DNSRData::NULL(bytes) => {
> > +             jsa.set_string_from_bytes("rdata", bytes)?;
> > +@@ -506,6 +518,9 @@ fn dns_log_json_answer(
> > +
> > +     if let Some(query) = response.queries.first() {
> > +         js.set_string_from_bytes("rrname", &query.name.value)?;
> > ++        if query.name.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++            js.set_bool("rrname_truncated", true)?;
> > ++        }
> > +         js.set_string("rrtype", &dns_rrtype_string(query.rrtype))?;
> > +     }
> > +     js.set_string("rcode", &dns_rcode_string(header.flags))?;
> > +@@ -532,6 +547,7 @@ fn dns_log_json_answer(
> > +                     | DNSRData::MX(name)
> > +                     | DNSRData::NS(name)
> > +                     | DNSRData::PTR(name) => {
> > ++                        // Flags like truncated not logged here as it
> > would break the schema.
> > +                         if !answer_types.contains_key(&type_string) {
> > +                             answer_types
> > +                                 .insert(type_string.to_string(),
> > JsonBuilder::try_new_array()?);
> > +@@ -620,6 +636,9 @@ fn dns_log_query(
> > +                 jb.set_string("type", "query")?;
> > +                 jb.set_uint("id", request.header.tx_id as u64)?;
> > +                 jb.set_string_from_bytes("rrname", &query.name.value)?;
> > ++                if query.name.flags.contains(DNSNameFlags::TRUNCATED) {
> > ++                    jb.set_bool("rrname_truncated", true)?;
> > ++                }
> > +                 jb.set_string("rrtype",
> > &dns_rrtype_string(query.rrtype))?;
> > +                 jb.set_uint("tx_id", tx.id - 1)?;
> > +                 if request.header.flags & 0x0040 != 0 {
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/files/CVE-2024-55628-004.patch
> > b/recipes-ids/suricata/files/CVE-2024-55628-004.patch
> > new file mode 100644
> > index 0000000..5a2bcf6
> > --- /dev/null
> > +++ b/recipes-ids/suricata/files/CVE-2024-55628-004.patch
> > @@ -0,0 +1,510 @@
> > +From 71212b78bd1b7b841c9d9a907d0b3eea71a54060 Mon Sep 17 00:00:00 2001
> > +From: Jason Ish<jason.ish@oisf.net>
> > +Date: Fri, 1 Nov 2024 11:39:23 -0600
> > +Subject: [PATCH] dns: provide events for recoverable parse errors
> > +
> > +Add events for the following resource name parsing issues:
> > +
> > +- name truncated as its too long
> > +- maximum number of labels reached
> > +- infinite loop
> > +
> > +Currently these events are only registered when encountered, but
> > +recoverable. That is where we are able to return some of the name,
> > +usually in a truncated state.
> > +
> > +As name parsing has many code paths, we pass in a pointer to a flag
> > +field that can be updated by the name parser, this is done in
> > +addition to the flags being set on a specific name as when logging we
> > +want to designate which fields are truncated, etc. But for alerts, we
> > +just care that something happened during the parse. It also reduces
> > +errors as it won't be forgotten to check for the flags and set the
> > +event if some new parser is written that also parses names.
> > +
> > +Ticket: #7280
> > +
> > +(cherry picked from commit 19cf0f81335d9f787d587450f7105ad95a648951)
> > +
> > +CVE: CVE-2024-55628
> > +Upstream-Status: Backport
> > [https://github.com/OISF/suricata/commit/71212b78bd1b7b841c9d9a907d0b3eea71a54060]
> > +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
> > +---
> > + rules/dns-events.rules |   9 +++
> > + rust/src/dns/dns.rs    |  36 ++++++++++-
> > + rust/src/dns/parser.rs | 136 +++++++++++++++++++++++++----------------
> > + 3 files changed, 124 insertions(+), 57 deletions(-)
> > +
> > +diff --git a/rules/dns-events.rules b/rules/dns-events.rules
> > +index d4c02b5..cc43629 100644
> > +--- a/rules/dns-events.rules
> > ++++ b/rules/dns-events.rules
> > +@@ -8,3 +8,12 @@ alert dns any any -> any any (msg:"SURICATA DNS Not a
> > response"; flow:to_client;
> > + # Z flag (reserved) not 0
> > + alert dns any any -> any any (msg:"SURICATA DNS Z flag set";
> > app-layer-event:dns.z_flag_set; classtype:protocol-command-decode;
> > sid:2240006; rev:2;)
> > + alert dns any any -> any any (msg:"SURICATA DNS Invalid opcode";
> > app-layer-event:dns.invalid_opcode; classtype:protocol-command-decode;
> > sid:2240007; rev:1;)
> > ++
> > ++# A resource name was too long (over 1025 chars)
> > ++alert dns any any -> any any (msg:"SURICATA DNS Name too long";
> > app-layer-event:dns.name_too_long; classtype:protocol-command-decode;
> > sid:224008; rev:1;)
> > ++
> > ++# An infinite loop was found while decoding a DNS resource name.
> > ++alert dns any any -> any any (msg:"SURICATA DNS Infinite loop";
> > app-layer-event:dns.infinite_loop; classtype:protocol-command-decode;
> > sid:224009; rev:1;)
> > ++
> > ++# Suricata's maximum number of DNS name labels was reached while parsing a
> > resource name.
> > ++alert dns any any -> any any (msg:"SURICATA DNS Too many labels";
> > app-layer-event:dns.too_many_labels; classtype:protocol-command-decode;
> > sid:224010; rev:1;)
> > +diff --git a/rust/src/dns/dns.rs b/rust/src/dns/dns.rs
> > +index 680bf7e..34406dc 100644
> > +--- a/rust/src/dns/dns.rs
> > ++++ b/rust/src/dns/dns.rs
> > +@@ -129,6 +129,12 @@ pub enum DNSEvent {
> > +     NotResponse,
> > +     ZFlagSet,
> > +     InvalidOpcode,
> > ++    /// A DNS resource name was exessively long and was truncated.
> > ++    NameTooLong,
> > ++    /// An infinite loop was found while parsing a name.
> > ++    InfiniteLoop,
> > ++    /// Too many labels were found.
> > ++    TooManyLabels,
> > + }
> > +
> > + #[derive(Debug, PartialEq, Eq)]
> > +@@ -418,7 +424,7 @@ impl DNSState {
> > +         };
> > +
> > +         match parser::dns_parse_request_body(body, input, header) {
> > +-            Ok((_, request)) => {
> > ++            Ok((_, (request, parse_flags))) => {
> > +                 if request.header.flags & 0x8000 != 0 {
> > +                     SCLogDebug!("DNS message is not a request");
> > +                     self.set_event(DNSEvent::NotRequest);
> > +@@ -441,6 +447,18 @@ impl DNSState {
> > +                     self.set_event(DNSEvent::InvalidOpcode);
> > +                 }
> > +
> > ++                if parse_flags.contains(DNSNameFlags::TRUNCATED) {
> > ++                    self.set_event(DNSEvent::NameTooLong);
> > ++                }
> > ++
> > ++                if parse_flags.contains(DNSNameFlags::INFINITE_LOOP) {
> > ++                    self.set_event(DNSEvent::InfiniteLoop);
> > ++                }
> > ++
> > ++                if parse_flags.contains(DNSNameFlags::LABEL_LIMIT) {
> > ++                    self.set_event(DNSEvent::TooManyLabels);
> > ++                }
> > ++
> > +                 return true;
> > +             }
> > +             Err(Err::Incomplete(_)) => {
> > +@@ -490,7 +508,7 @@ impl DNSState {
> > +         };
> > +
> > +         match parser::dns_parse_response_body(body, input, header) {
> > +-            Ok((_, response)) => {
> > ++            Ok((_, (response, parse_flags))) => {
> > +                 SCLogDebug!("Response header flags: {}",
> > response.header.flags);
> > +
> > +                 if response.header.flags & 0x8000 == 0 {
> > +@@ -519,6 +537,18 @@ impl DNSState {
> > +                     self.set_event(DNSEvent::InvalidOpcode);
> > +                 }
> > +
> > ++                if parse_flags.contains(DNSNameFlags::TRUNCATED) {
> > ++                    self.set_event(DNSEvent::NameTooLong);
> > ++                }
> > ++
> > ++                if parse_flags.contains(DNSNameFlags::INFINITE_LOOP) {
> > ++                    self.set_event(DNSEvent::InfiniteLoop);
> > ++                }
> > ++
> > ++                if parse_flags.contains(DNSNameFlags::LABEL_LIMIT) {
> > ++                    self.set_event(DNSEvent::TooManyLabels);
> > ++                }
> > ++
> > +                 return true;
> > +             }
> > +             Err(Err::Incomplete(_)) => {
> > +@@ -718,7 +748,7 @@ fn probe(input: &[u8], dlen: usize) -> (bool, bool,
> > bool) {
> > +     }
> > +
> > +     match parser::dns_parse_request(input) {
> > +-        Ok((_, request)) => {
> > ++        Ok((_, (request, _))) => {
> > +             return probe_header_validity(&request.header, dlen);
> > +         }
> > +         Err(Err::Incomplete(_)) => match parser::dns_parse_header(input) {
> > +diff --git a/rust/src/dns/parser.rs b/rust/src/dns/parser.rs
> > +index 12929bc..c98ba05 100644
> > +--- a/rust/src/dns/parser.rs
> > ++++ b/rust/src/dns/parser.rs
> > +@@ -81,7 +81,7 @@ static MAX_NAME_LEN: usize = 1025;
> > + /// Parameters:
> > + ///   start: the start of the name
> > + ///   message: the complete message that start is a part of with the DNS
> > header
> > +-pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8]) ->
> > IResult<&'b [u8], DNSName> {
> > ++pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b [u8], parse_flags:
> > &mut DNSNameFlags) -> IResult<&'b [u8], DNSName> {
> > +     let mut pos = start;
> > +     let mut pivot = start;
> > +     let mut name: Vec<u8> = Vec::with_capacity(32);
> > +@@ -166,6 +166,8 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b
> > [u8]) -> IResult<&'b [u8
> > +         }
> > +     }
> > +
> > ++    parse_flags.insert(flags);
> > ++
> > +     // If we followed a pointer we return the position after the first
> > +     // pointer followed. Is there a better way to see if these slices
> > +     // diverged from each other?  A straight up comparison would
> > +@@ -188,7 +190,7 @@ pub fn dns_parse_name<'b>(start: &'b [u8], message: &'b
> > [u8]) -> IResult<&'b [u8
> > + /// multi-string TXT entry as a single quote string, similar to the
> > + /// output of dig. Something to consider for a future version.
> > + fn dns_parse_answer<'a>(
> > +-    slice: &'a [u8], message: &'a [u8], count: usize,
> > ++    slice: &'a [u8], message: &'a [u8], count: usize, flags: &mut
> > DNSNameFlags,
> > + ) -> IResult<&'a [u8], Vec<DNSAnswerEntry>> {
> > +     let mut answers = Vec::new();
> > +     let mut input = slice;
> > +@@ -201,8 +203,10 @@ fn dns_parse_answer<'a>(
> > +         data: &'a [u8],
> > +     }
> > +
> > +-    fn subparser<'a>(i: &'a [u8], message: &'a [u8]) -> IResult<&'a [u8],
> > Answer<'a>> {
> > +-        let (i, name) = dns_parse_name(i, message)?;
> > ++    fn subparser<'a>(
> > ++        i: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++    ) -> IResult<&'a [u8], Answer<'a>> {
> > ++        let (i, name) = dns_parse_name(i, message, flags)?;
> > +         let (i, rrtype) = be_u16(i)?;
> > +         let (i, rrclass) = be_u16(i)?;
> > +         let (i, ttl) = be_u32(i)?;
> > +@@ -218,7 +222,7 @@ fn dns_parse_answer<'a>(
> > +     }
> > +
> > +     for _ in 0..count {
> > +-        match subparser(input, message) {
> > ++        match subparser(input, message, flags) {
> > +             Ok((rem, val)) => {
> > +                 let n = match val.rrtype {
> > +                     DNS_RECORD_TYPE_TXT => {
> > +@@ -236,7 +240,7 @@ fn dns_parse_answer<'a>(
> > +                     }
> > +                 };
> > +                 let result: IResult<&'a [u8], Vec<DNSRData>> =
> > +-                    many_m_n(1, n, complete(|b| dns_parse_rdata(b,
> > message, val.rrtype)))(val.data);
> > ++                    many_m_n(1, n, complete(|b| dns_parse_rdata(b,
> > message, val.rrtype, flags)))(val.data);
> > +                 match result {
> > +                     Ok((_, rdatas)) => {
> > +                         for rdata in rdatas {
> > +@@ -266,18 +270,19 @@ fn dns_parse_answer<'a>(
> > +
> > + pub fn dns_parse_response_body<'a>(
> > +     i: &'a [u8], message: &'a [u8], header: DNSHeader,
> > +-) -> IResult<&'a [u8], DNSResponse> {
> > +-    let (i, queries) = count(|b| dns_parse_query(b, message),
> > header.questions as usize)(i)?;
> > +-    let (i, answers) = dns_parse_answer(i, message, header.answer_rr as
> > usize)?;
> > +-    let (i, authorities) = dns_parse_answer(i, message,
> > header.authority_rr as usize)?;
> > ++) -> IResult<&'a [u8], (DNSResponse, DNSNameFlags)> {
> > ++    let mut flags = DNSNameFlags::default();
> > ++    let (i, queries) = count(|b| dns_parse_query(b, message, &mut flags),
> > header.questions as usize)(i)?;
> > ++    let (i, answers) = dns_parse_answer(i, message, header.answer_rr as
> > usize, &mut flags)?;
> > ++    let (i, authorities) = dns_parse_answer(i, message,
> > header.authority_rr as usize, &mut flags)?;
> > +     Ok((
> > +         i,
> > +-        DNSResponse {
> > ++        (DNSResponse {
> > +             header,
> > +             queries,
> > +             answers,
> > +             authorities,
> > +-        },
> > ++        }, flags),
> > +     ))
> > + }
> > +
> > +@@ -286,9 +291,9 @@ pub fn dns_parse_response_body<'a>(
> > + /// Arguments are suitable for using with call!:
> > + ///
> > + ///    call!(complete_dns_message_buffer)
> > +-pub fn dns_parse_query<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSQueryEntry> {
> > ++pub fn dns_parse_query<'a>(input: &'a [u8], message: &'a [u8], flags: &mut
> > DNSNameFlags) -> IResult<&'a [u8], DNSQueryEntry> {
> > +     let i = input;
> > +-    let (i, name) = dns_parse_name(i, message)?;
> > ++    let (i, name) = dns_parse_name(i, message, flags)?;
> > +     let (i, rrtype) = be_u16(i)?;
> > +     let (i, rrclass) = be_u16(i)?;
> > +     Ok((
> > +@@ -309,22 +314,30 @@ fn dns_parse_rdata_aaaa(input: &[u8]) ->
> > IResult<&[u8], DNSRData> {
> > +     rest(input).map(|(input, data)| (input,
> > DNSRData::AAAA(data.to_vec())))
> > + }
> > +
> > +-fn dns_parse_rdata_cname<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > +-    dns_parse_name(input, message).map(|(input, name)| (input,
> > DNSRData::CNAME(name)))
> > ++fn dns_parse_rdata_cname<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > ++    dns_parse_name(input, message, flags).map(|(input, name)| (input,
> > DNSRData::CNAME(name)))
> > + }
> > +
> > +-fn dns_parse_rdata_ns<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > +-    dns_parse_name(input, message).map(|(input, name)| (input,
> > DNSRData::NS(name)))
> > ++fn dns_parse_rdata_ns<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > ++    dns_parse_name(input, message, flags).map(|(input, name)| (input,
> > DNSRData::NS(name)))
> > + }
> > +
> > +-fn dns_parse_rdata_ptr<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > +-    dns_parse_name(input, message).map(|(input, name)| (input,
> > DNSRData::PTR(name)))
> > ++fn dns_parse_rdata_ptr<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > ++    dns_parse_name(input, message, flags).map(|(input, name)| (input,
> > DNSRData::PTR(name)))
> > + }
> > +
> > +-fn dns_parse_rdata_soa<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > ++fn dns_parse_rdata_soa<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > +     let i = input;
> > +-    let (i, mname) = dns_parse_name(i, message)?;
> > +-    let (i, rname) = dns_parse_name(i, message)?;
> > ++    let (i, mname) = dns_parse_name(i, message, flags)?;
> > ++    let (i, rname) = dns_parse_name(i, message, flags)?;
> > +     let (i, serial) = be_u32(i)?;
> > +     let (i, refresh) = be_u32(i)?;
> > +     let (i, retry) = be_u32(i)?;
> > +@@ -344,20 +357,24 @@ fn dns_parse_rdata_soa<'a>(input: &'a [u8], message:
> > &'a [u8]) -> IResult<&'a [u
> > +     ))
> > + }
> > +
> > +-fn dns_parse_rdata_mx<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > ++fn dns_parse_rdata_mx<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > +     // For MX we skip over the preference field before
> > +     // parsing out the name.
> > +     let (i, _) = be_u16(input)?;
> > +-    let (i, name) = dns_parse_name(i, message)?;
> > ++    let (i, name) = dns_parse_name(i, message, flags)?;
> > +     Ok((i, DNSRData::MX(name)))
> > + }
> > +
> > +-fn dns_parse_rdata_srv<'a>(input: &'a [u8], message: &'a [u8]) ->
> > IResult<&'a [u8], DNSRData> {
> > ++fn dns_parse_rdata_srv<'a>(
> > ++    input: &'a [u8], message: &'a [u8], flags: &mut DNSNameFlags,
> > ++) -> IResult<&'a [u8], DNSRData> {
> > +     let i = input;
> > +     let (i, priority) = be_u16(i)?;
> > +     let (i, weight) = be_u16(i)?;
> > +     let (i, port) = be_u16(i)?;
> > +-    let (i, target) = dns_parse_name(i, message)?;
> > ++    let (i, target) = dns_parse_name(i, message, flags)?;
> > +     Ok((
> > +         i,
> > +         DNSRData::SRV(DNSRDataSRV {
> > +@@ -398,26 +415,26 @@ fn dns_parse_rdata_unknown(input: &[u8]) ->
> > IResult<&[u8], DNSRData> {
> > + }
> > +
> > + pub fn dns_parse_rdata<'a>(
> > +-    input: &'a [u8], message: &'a [u8], rrtype: u16,
> > ++    input: &'a [u8], message: &'a [u8], rrtype: u16, flags: &mut
> > DNSNameFlags
> > + ) -> IResult<&'a [u8], DNSRData> {
> > +     match rrtype {
> > +         DNS_RECORD_TYPE_A => dns_parse_rdata_a(input),
> > +         DNS_RECORD_TYPE_AAAA => dns_parse_rdata_aaaa(input),
> > +-        DNS_RECORD_TYPE_CNAME => dns_parse_rdata_cname(input, message),
> > +-        DNS_RECORD_TYPE_PTR => dns_parse_rdata_ptr(input, message),
> > +-        DNS_RECORD_TYPE_SOA => dns_parse_rdata_soa(input, message),
> > +-        DNS_RECORD_TYPE_MX => dns_parse_rdata_mx(input, message),
> > +-        DNS_RECORD_TYPE_NS => dns_parse_rdata_ns(input, message),
> > ++        DNS_RECORD_TYPE_CNAME => dns_parse_rdata_cname(input, message,
> > flags),
> > ++        DNS_RECORD_TYPE_PTR => dns_parse_rdata_ptr(input, message, flags),
> > ++        DNS_RECORD_TYPE_SOA => dns_parse_rdata_soa(input, message, flags),
> > ++        DNS_RECORD_TYPE_MX => dns_parse_rdata_mx(input, message, flags),
> > ++        DNS_RECORD_TYPE_NS => dns_parse_rdata_ns(input, message, flags),
> > +         DNS_RECORD_TYPE_TXT => dns_parse_rdata_txt(input),
> > +         DNS_RECORD_TYPE_NULL => dns_parse_rdata_null(input),
> > +         DNS_RECORD_TYPE_SSHFP => dns_parse_rdata_sshfp(input),
> > +-        DNS_RECORD_TYPE_SRV => dns_parse_rdata_srv(input, message),
> > ++        DNS_RECORD_TYPE_SRV => dns_parse_rdata_srv(input, message, flags),
> > +         _ => dns_parse_rdata_unknown(input),
> > +     }
> > + }
> > +
> > + /// Parse a DNS request.
> > +-pub fn dns_parse_request(input: &[u8]) -> IResult<&[u8], DNSRequest> {
> > ++pub fn dns_parse_request(input: &[u8]) -> IResult<&[u8], (DNSRequest,
> > DNSNameFlags)> {
> > +     let i = input;
> > +     let (i, header) = dns_parse_header(i)?;
> > +     dns_parse_request_body(i, input, header)
> > +@@ -425,10 +442,11 @@ pub fn dns_parse_request(input: &[u8]) ->
> > IResult<&[u8], DNSRequest> {
> > +
> > + pub fn dns_parse_request_body<'a>(
> > +     input: &'a [u8], message: &'a [u8], header: DNSHeader,
> > +-) -> IResult<&'a [u8], DNSRequest> {
> > ++) -> IResult<&'a [u8], (DNSRequest, DNSNameFlags)> {
> > ++    let mut flags = DNSNameFlags::default();
> > +     let i = input;
> > +-    let (i, queries) = count(|b| dns_parse_query(b, message),
> > header.questions as usize)(i)?;
> > +-    Ok((i, DNSRequest { header, queries }))
> > ++    let (i, queries) = count(|b| dns_parse_query(b, message, &mut flags),
> > header.questions as usize)(i)?;
> > ++    Ok((i, (DNSRequest { header, queries }, flags)))
> > + }
> > +
> > + #[cfg(test)]
> > +@@ -447,7 +465,8 @@ mod tests {
> > +             0x03, 0x63, 0x6f, 0x6d, 0x00, 0x00, 0x01, 0x00, /* .com.... */
> > +         ];
> > +         let expected_remainder: &[u8] = &[0x00, 0x01, 0x00];
> > +-        let (remainder, name) = dns_parse_name(buf, buf).unwrap();
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let (remainder, name) = dns_parse_name(buf, buf, &mut
> > flags).unwrap();
> > +         assert_eq!("client-cf.dropbox.com".as_bytes(), &name.value[..]);
> > +         assert_eq!(remainder, expected_remainder);
> > +     }
> > +@@ -481,7 +500,8 @@ mod tests {
> > +
> > +         // The name at offset 54 is the complete name.
> > +         let start1 = &buf[54..];
> > +-        let res1 = dns_parse_name(start1, message);
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let res1 = dns_parse_name(start1, message, &mut flags);
> > +         assert_eq!(
> > +             res1,
> > +             Ok((
> > +@@ -496,7 +516,8 @@ mod tests {
> > +         // The second name starts at offset 80, but is just a pointer
> > +         // to the first.
> > +         let start2 = &buf[80..];
> > +-        let res2 = dns_parse_name(start2, message);
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let res2 = dns_parse_name(start2, message, &mut flags);
> > +         assert_eq!(
> > +             res2,
> > +             Ok((
> > +@@ -511,7 +532,8 @@ mod tests {
> > +         // The third name starts at offset 94, but is a pointer to a
> > +         // portion of the first.
> > +         let start3 = &buf[94..];
> > +-        let res3 = dns_parse_name(start3, message);
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let res3 = dns_parse_name(start3, message, &mut flags);
> > +         assert_eq!(
> > +             res3,
> > +             Ok((
> > +@@ -526,7 +548,8 @@ mod tests {
> > +         // The fourth name starts at offset 110, but is a pointer to a
> > +         // portion of the first.
> > +         let start4 = &buf[110..];
> > +-        let res4 = dns_parse_name(start4, message);
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let res4 = dns_parse_name(start4, message, &mut flags);
> > +         assert_eq!(
> > +             res4,
> > +             Ok((
> > +@@ -567,7 +590,8 @@ mod tests {
> > +         // packet).
> > +         let start: &[u8] = &buf[100..];
> > +
> > +-        let res = dns_parse_name(start, message);
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let res = dns_parse_name(start, message, &mut flags);
> > +         assert_eq!(
> > +             res,
> > +             Ok((
> > +@@ -595,7 +619,7 @@ mod tests {
> > +
> > +         let res = dns_parse_request(pkt);
> > +         match res {
> > +-            Ok((rem, request)) => {
> > ++            Ok((rem, (request, _flags))) => {
> > +                 // For now we have some remainder data as there is an
> > +                 // additional record type we don't parse yet.
> > +                 assert!(!rem.is_empty());
> > +@@ -626,7 +650,7 @@ mod tests {
> > +     }
> > +
> > +     /// Parse a DNS response.
> > +-    fn dns_parse_response(message: &[u8]) -> IResult<&[u8], DNSResponse> {
> > ++    fn dns_parse_response(message: &[u8]) -> IResult<&[u8], (DNSResponse,
> > DNSNameFlags)> {
> > +         let i = message;
> > +         let (i, header) = dns_parse_header(i)?;
> > +         dns_parse_response_body(i, message, header)
> > +@@ -653,7 +677,7 @@ mod tests {
> > +
> > +         let res = dns_parse_response(pkt);
> > +         match res {
> > +-            Ok((rem, response)) => {
> > ++            Ok((rem, (response, _flags))) => {
> > +                 // The response should be full parsed.
> > +                 assert_eq!(rem.len(), 0);
> > +
> > +@@ -745,7 +769,7 @@ mod tests {
> > +
> > +         let res = dns_parse_response(pkt);
> > +         match res {
> > +-            Ok((rem, response)) => {
> > ++            Ok((rem, (response, _flags))) => {
> > +                 // For now we have some remainder data as there is an
> > +                 // additional record type we don't parse yet.
> > +                 assert!(!rem.is_empty());
> > +@@ -812,7 +836,7 @@ mod tests {
> > +
> > +         let res = dns_parse_response(pkt);
> > +         match res {
> > +-            Ok((rem, response)) => {
> > ++            Ok((rem, (response, _flags))) => {
> > +                 // The response should be fully parsed.
> > +                 assert_eq!(rem.len(), 0);
> > +
> > +@@ -924,7 +948,7 @@ mod tests {
> > +
> > +         let res = dns_parse_response(pkt);
> > +         match res {
> > +-            Ok((rem, response)) => {
> > ++            Ok((rem, (response, _flags))) => {
> > +                 // The data should be fully parsed.
> > +                 assert_eq!(rem.len(), 0);
> > +
> > +@@ -978,7 +1002,8 @@ mod tests {
> > +             }
> > +         }
> > +
> > +-        let (rem, name) = dns_parse_name(&buf, &buf).unwrap();
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let (rem, name) = dns_parse_name(&buf, &buf, &mut flags).unwrap();
> > +         assert_eq!(name.value.len(), MAX_NAME_LEN);
> > +         assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
> > +         assert!(rem.is_empty());
> > +@@ -995,7 +1020,8 @@ mod tests {
> > +         // This should fail as we've hit the segment limit without a
> > +         // pointer, we'd need to keep parsing more segments to figure
> > +         // out where the next data point lies.
> > +-        assert!(dns_parse_name(&buf, &buf).is_err());
> > ++        let mut flags = DNSNameFlags::default();
> > ++        assert!(dns_parse_name(&buf, &buf, &mut flags).is_err());
> > +     }
> > +
> > +     #[test]
> > +@@ -1015,7 +1041,8 @@ mod tests {
> > +         buf.push(0b1100_0000);
> > +         buf.push(0b000_0000);
> > +
> > +-        let (_rem, name) = dns_parse_name(&buf[4..], &buf).unwrap();
> > ++        let mut flags = DNSNameFlags::default();
> > ++        let (_rem, name) = dns_parse_name(&buf[4..], &buf, &mut
> > flags).unwrap();
> > +         assert_eq!(name.value.len(), 255);
> > +         assert!(name.flags.contains(DNSNameFlags::TRUNCATED));
> > +     }
> > +@@ -1025,6 +1052,7 @@ mod tests {
> > +         let mut buf = vec![];
> > +         buf.push(0b1100_0000);
> > +         buf.push(0b0000_0000);
> > +-        assert!(dns_parse_name(&buf, &buf).is_err());
> > ++        let mut flags = DNSNameFlags::default();
> > ++        assert!(dns_parse_name(&buf, &buf, &mut flags).is_err());
> > +     }
> > + }
> > +--
> > +2.50.1
> > +
> > diff --git a/recipes-ids/suricata/suricata_7.0.0.bb
> > b/recipes-ids/suricata/suricata_7.0.0.bb
> > index 4a1857e..58ed688 100644
> > --- a/recipes-ids/suricata/suricata_7.0.0.bb
> > +++ b/recipes-ids/suricata/suricata_7.0.0.bb
> > @@ -31,6 +31,13 @@ SRC_URI += " \
> >       file://CVE-2024-32867-002.patch  \
> >       file://CVE-2024-32867-003.patch  \
> >       file://CVE-2024-32867-004.patch  \
> > +file://CVE-2024-55627-001.patch  \
> > +file://CVE-2024-55627-002.patch  \
> > +file://CVE-2024-55627-003.patch  \
> > +file://CVE-2024-55628-001.patch  \
> > +file://CVE-2024-55628-002.patch  \
> > +file://CVE-2024-55628-003.patch  \
> > +file://CVE-2024-55628-004.patch  \
> >       "
> >
> >   inherit autotools pkgconfig python3native systemd ptest cargo
> >   cargo-update-recipe-crates
>

