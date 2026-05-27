Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4133CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 10:22:24 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17394.1779877340426215421
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 03:22:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lkZXJsML;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba17c8cfacso121011065ad.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 03:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779877340; x=1780482140; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7tj8Br3oQaCThzxTr7M2FTe8bgDTknZE1U2mdX20xA=;
        b=lkZXJsMLvYcG64SX5O65Ue+OzOlGaogIOxb6kJZUEm8z9ZKP1aw4QItPawZk0eTKtL
         hHa3KNBN5jwWKKlfnIZCucD2jQoohE/eoquapfNj/cGlxbMlrz2JOtDSuJtEu0GdFGid
         dle1Q8Ax+Zmo2oL/A57gQOZ4rYUrWbNCWl/n4TJfe6VT6onJTL4gtGSYRbfXWVecxqW6
         imA/Qxg9QSq6RkyY9yV1Wf4Ig+2hyYM6SQjJkoO1PaNa4/7fHljeXNhfNx2Q7ne4+rWx
         nCBiir5j9IpDS65OcmQfwqL9bmlERg9F3ZqGQJERiKCKC2tPX4/np7+VC9zN2p019olO
         qpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779877340; x=1780482140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7tj8Br3oQaCThzxTr7M2FTe8bgDTknZE1U2mdX20xA=;
        b=UWKO4BdWHq452/tRRvVmk8zJh1b2tMNDn0fTQSiMvuDa6Z/x3UX57RozAjdXZGwzrw
         JPK2KwxcP12IcVoPBAt/R64uXOLQj4gYmp7uUaYBf+Qt86yLRuv34vFf3fJEcdprx3wI
         c2bjJ5nmbGQgSPomcdQpYu6Ydr9FPhfBN6oS02LJcYBYlBBNyN0kDbAtTnpZkpWzYWkG
         lpRs94yl9rxO/IeMIWYNX/tvM4bo0eaCmrj2dzz3KWC3lgMMKvDF02wp9D/MmSdhjU4u
         HIH3/N8n9uHZU8piJ1Gq01UoU6V1tnxS56PFq74YBl/jNW4eHJ0vSEqI2gDMVa9Lwlfo
         2GYQ==
X-Gm-Message-State: AOJu0Yxag/ZxFG2fcongMEUhnox6qzPbtibkrqG/WmJFwLzHmxZPPf4R
	rChVLb2vRLBsYax3GxafdPH1HlCyu2YRrJBN/EDXWyCtntRrhni3LX950VVFeA==
X-Gm-Gg: Acq92OHIjVPYiMq6z/49IxPJ8xdGoFESEYQX6TwED1FaHu1kLynaqDA6wJW0jxSlgXW
	j16fsSSOGiihp9r9+Km4EZCAG6nTWaKf/a2+wtymH3bCMSQv5uiMJBcBf83Mv3auZqY8Z7/Nmd/
	+6UgB4+b2N7nSN8rDJ+PuHy/dz/E/qa5/MQtPdTPPOMkiFCkld7KbvPIdqNXI7E6v1nzRIy/LWI
	vdnnRfo2XwFBTX0f/1KbvicA4uEzUvIIFWZmBEA0c0knMCAn65ydcTAXdhKOItXl+m+e2Jl4tQn
	NekPYJwmATozrPdGS0kmIfxd+MIyDlA26zn8EGYZ6N27titzUzObTtutnvjzWIGlCPNnk+xcqur
	1rMZCc64XQSIx2VPfZ/memqXRSlMtvEfnUka/T9i4//2rn3h7HXvPGTRTGsmQPUsccFfRKv1u0b
	1Wb3BmiJaxyske+qRIyvPkTRUZooI=
X-Received: by 2002:a17:903:1b6d:b0:2b2:3bb6:fbf8 with SMTP id d9443c01a7336-2beb03884aamr244167915ad.16.1779877339523;
        Wed, 27 May 2026 03:22:19 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.135.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695c40sm137963575ad.5.2026.05.27.03.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:22:18 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Shaik Moin <moin.shaik@partner.bmwgroup.com>
Subject: [meta-lts-collab][kirkstone][PATCH] binutils: Fix CVE-2025-69652, CVE-2025-69649 and CVE-2026-4647
Date: Wed, 27 May 2026 15:52:01 +0530
Message-Id: <20260527102201.520139-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 10:22:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4071

From: Shaik Moin <moin.shaik@partner.bmwgroup.com>

Backport fix for CVE-2025-69652, CVE-2025-69649 and CVE-2026-4647

Patches are refreshed based on code base.

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 .../binutils/binutils/CVE-2025-69649.patch    |  42 ++++
 .../binutils/binutils/CVE-2025-69652.patch    |  45 ++++
 .../binutils/binutils/CVE-2026-4647.patch     | 233 ++++++++++++++++++
 .../binutils/binutils_%.bbappend              |   6 +
 4 files changed, 326 insertions(+)
 create mode 100644 meta-core/recipes-devtools/binutils/binutils/CVE-2025-69649.patch
 create mode 100644 meta-core/recipes-devtools/binutils/binutils/CVE-2025-69652.patch
 create mode 100644 meta-core/recipes-devtools/binutils/binutils/CVE-2026-4647.patch
 create mode 100644 meta-core/recipes-devtools/binutils/binutils_%.bbappend

diff --git a/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69649.patch b/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69649.patch
new file mode 100644
index 0000000..767c2d9
--- /dev/null
+++ b/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69649.patch
@@ -0,0 +1,42 @@
+From 48f8779129c6dcda57a003e81ddabf70451c78bd Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Wed, 6 May 2026 16:20:04 +0530
+Subject: [PATCH] binutils: Fix CVE-2025-69649
+
+PR 33697, fuzzer segfault
+
+PR 33697
+* readelf.c (process_relocs): Don't segfault on no sections.
+
+CVE: CVE-2025-69649
+
+Upstream-Status: Backport [https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=66a3492ce68e1ae45b2489bd9a815c39ea5d7f66]
+
+Patch is refreshed based on code base.
+
+Signed-off-by: Alan Modra <amodra@gmail.com>
+Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
+---
+ binutils/readelf.c | 6 +++---
+ 1 file changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/binutils/readelf.c b/binutils/readelf.c
+index 137a505b..8a948703 100644
+--- a/binutils/readelf.c
++++ b/binutils/readelf.c
+@@ -8227,9 +8227,9 @@ process_relocs (Filedata * filedata)
+       unsigned long i;
+       bool found = false;
+ 
+-      for (i = 0, section = filedata->section_headers;
+-	   i < filedata->file_header.e_shnum;
+-	   i++, section++)
++      section = filedata->section_headers;
++      if (section != NULL)
++       for (i = 0; i < filedata->file_header.e_shnum; i++, section++)
+ 	{
+ 	  if (   section->sh_type != SHT_RELA
+ 	      && section->sh_type != SHT_REL
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69652.patch b/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69652.patch
new file mode 100644
index 0000000..d3c1d61
--- /dev/null
+++ b/meta-core/recipes-devtools/binutils/binutils/CVE-2025-69652.patch
@@ -0,0 +1,45 @@
+From d0970e0cdc93676eb5fec9daf292a8d7ff17db92 Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Thu, 30 Apr 2026 16:52:37 +0530
+Subject: [PATCH] binutils: Fix CVE-2025-69652
+
+PR 33701, abort in byte_get_little_endian
+
+PR 33701
+* dwarf.c (process_debug_info): Set debug_info_p NULL when
+DEBUG_INFO_UNAVAILABLE.
+
+CVE: CVE-2025-69652
+
+Upstream-Status: Backport [https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=44b79abd0fa12e7947252eb4c6e5d16ed6033e01]
+
+Patch is refreshed based on code base.
+
+Signed-off-by: Alan Modra <amodra@gmail.com>
+Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
+---
+ binutils/dwarf.c | 8 +++++---
+ 1 file changed, 5 insertions(+), 3 deletions(-)
+
+diff --git a/binutils/dwarf.c b/binutils/dwarf.c
+index 47fd34b8..ad08466d 100644
+--- a/binutils/dwarf.c
++++ b/binutils/dwarf.c
+@@ -4059,9 +4059,11 @@ process_debug_info (struct dwarf_section * section,
+ 	      break;
+ 	    }
+ 
+-	  debug_info *debug_info_p =
+-	    (debug_information && unit < alloc_num_debug_info_entries)
+-	    ? debug_information + unit : NULL;
++	  debug_info *debug_info_p = NULL;
++	  if (debug_information
++	      && num_debug_info_entries != DEBUG_INFO_UNAVAILABLE
++		  && unit < alloc_num_debug_info_entries)
++		debug_info_p = debug_information + unit;
+ 
+ 	  assert (!debug_info_p
+ 		  || (debug_info_p->num_loc_offsets
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-devtools/binutils/binutils/CVE-2026-4647.patch b/meta-core/recipes-devtools/binutils/binutils/CVE-2026-4647.patch
new file mode 100644
index 0000000..a665007
--- /dev/null
+++ b/meta-core/recipes-devtools/binutils/binutils/CVE-2026-4647.patch
@@ -0,0 +1,233 @@
+From 402aadde9f3125f9a5a42ea5a0cdf45bac2fee9f Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Mon, 4 May 2026 10:55:34 +0530
+Subject: [PATCH] binutils: Fix CVE-2026-4647
+
+PR33919 Out-of-bounds read in XCOFF relocation processing
+
+PR 33919
+* coff-rs6000.c (xcoff_calculate_relocation): Don't use explicit
+array size.
+(xcoff_complain_overflow): Likewise.
+(xcoff_rtype2howto): Return a NULL howto rather than aborting.
+(_bfd_xcoff_reloc_name_lookup): Use ARRAY_SIZE.
+(xcoff_ppc_relocate_section): Sanity check reloc r_type before
+accessing xcoff_howto_table.  Print r_type using %#x.  Remove
+now redundant later reloc r_type sanity check.
+* coff64-rs6000.c: Similarly.
+* libxcoff.h (XCOFF_MAX_CALCULATE_RELOCATION): Don't define.
+(XCOFF_MAX_COMPLAIN_OVERFLOW): Don't define.
+
+CVE: CVE-2026-4647
+
+Upstream-Status: Backport [https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=9e99dbc1f19ffaf18d0250788951706066ebe7f2]
+
+Patch is refreshed based on code base.
+
+Signed-off-by: Alan Modra <amodra@gmail.com>
+Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
+---
+ bfd/coff-rs6000.c   | 36 +++++++++++++++++++++---------------
+ bfd/coff64-rs6000.c | 33 ++++++++++++++++++++-------------
+ bfd/libxcoff.h      |  3 ---
+ 3 files changed, 41 insertions(+), 31 deletions(-)
+
+diff --git a/bfd/coff-rs6000.c b/bfd/coff-rs6000.c
+index fa089732..8b52b537 100644
+--- a/bfd/coff-rs6000.c
++++ b/bfd/coff-rs6000.c
+@@ -155,8 +155,7 @@ static xcoff_complain_function xcoff_complain_overflow_bitfield_func;
+ static xcoff_complain_function xcoff_complain_overflow_signed_func;
+ static xcoff_complain_function xcoff_complain_overflow_unsigned_func;
+ 
+-xcoff_reloc_function *const
+-xcoff_calculate_relocation[XCOFF_MAX_CALCULATE_RELOCATION] =
++xcoff_reloc_function *const xcoff_calculate_relocation[] =
+ {
+   xcoff_reloc_type_pos,  /* R_POS   (0x00) */
+   xcoff_reloc_type_neg,  /* R_NEG   (0x01) */
+@@ -210,8 +209,7 @@ xcoff_calculate_relocation[XCOFF_MAX_CALCULATE_RELOCATION] =
+   xcoff_reloc_type_toc,  /* R_TOCL    (0x31) */
+ };
+ 
+-xcoff_complain_function *const
+-xcoff_complain_overflow[XCOFF_MAX_COMPLAIN_OVERFLOW] =
++xcoff_complain_function *const xcoff_complain_overflow[] =
+ {
+   xcoff_complain_overflow_dont_func,
+   xcoff_complain_overflow_bitfield_func,
+@@ -1158,8 +1156,11 @@ reloc_howto_type xcoff_howto_table[] =
+ void
+ xcoff_rtype2howto (arelent *relent, struct internal_reloc *internal)
+ {
+-  if (internal->r_type > R_TOCL)
+-    abort ();
++  if (internal->r_type >= ARRAY_SIZE (xcoff_howto_table))
++    {
++      relent->howto = NULL;
++      return;
++    }
+ 
+   /* Default howto layout works most of the time */
+   relent->howto = &xcoff_howto_table[internal->r_type];
+@@ -1183,7 +1184,7 @@ xcoff_rtype2howto (arelent *relent, struct internal_reloc *internal)
+   if (relent->howto->dst_mask != 0
+       && (relent->howto->bitsize
+ 	  != ((unsigned int) internal->r_size & 0x1f) + 1))
+-    abort ();
++    relent->howto = NULL;
+ }
+ 
+ reloc_howto_type *
+@@ -1236,9 +1237,7 @@ _bfd_xcoff_reloc_name_lookup (bfd *abfd ATTRIBUTE_UNUSED,
+ {
+   unsigned int i;
+ 
+-  for (i = 0;
+-       i < sizeof (xcoff_howto_table) / sizeof (xcoff_howto_table[0]);
+-       i++)
++  for (i = 0; i < ARRAY_SIZE (xcoff_howto_table); i++)
+     if (xcoff_howto_table[i].name != NULL
+ 	&& strcasecmp (xcoff_howto_table[i].name, r_name) == 0)
+       return &xcoff_howto_table[i];
+@@ -3654,6 +3653,14 @@ xcoff_ppc_relocate_section (bfd *output_bfd,
+ 	 the csect including the symbol which it references.  */
+       if (rel->r_type == R_REF)
+ 	continue;
++      if (rel->r_type >= ARRAY_SIZE (xcoff_howto_table))
++       {
++         /* xgettext:c-format */
++         _bfd_error_handler (_("%pB: unsupported relocation type %#x"),
++                             input_bfd, rel->r_type);
++         bfd_set_error (bfd_error_bad_value);
++         return false;
++       }
+ 
+       /* Retrieve default value in HOWTO table and fix up according
+ 	 to r_size field, if it can be different.
+@@ -3677,7 +3684,7 @@ xcoff_ppc_relocate_section (bfd *output_bfd,
+ 
+ 		sprintf_vma (vaddr_buf, rel->r_vaddr);
+ 		_bfd_error_handler
+-		  (_("%pB: relocation (%d) at 0x%s has wrong r_rsize (0x%x)\n"),
++		  (_("%pB: relocation (%#x) at 0x%s has wrong r_rsize (0x%x)\n"),
+ 		   input_bfd, rel->r_type, vaddr_buf, rel->r_size);
+ 		return false;
+ 	      }
+@@ -3754,10 +3761,9 @@ xcoff_ppc_relocate_section (bfd *output_bfd,
+ 	    }
+ 	}
+ 
+-      if (rel->r_type >= XCOFF_MAX_CALCULATE_RELOCATION
+-	  || !((*xcoff_calculate_relocation[rel->r_type])
+-	       (input_bfd, input_section, output_bfd, rel, sym, &howto, val,
+-		addend, &relocation, contents)))
++      if (!((*xcoff_calculate_relocation[rel->r_type])
++	   (input_bfd, input_section, output_bfd, rel, sym, &howto, val,
++	    addend, &relocation, contents)))
+ 	return false;
+ 
+       /* address */
+diff --git a/bfd/coff64-rs6000.c b/bfd/coff64-rs6000.c
+index 01326d45..09998764 100644
+--- a/bfd/coff64-rs6000.c
++++ b/bfd/coff64-rs6000.c
+@@ -177,8 +177,7 @@ static bool xcoff64_bad_format_hook
+ /* Relocation functions */
+ static xcoff_reloc_function xcoff64_reloc_type_br;
+ 
+-xcoff_reloc_function *const
+-xcoff64_calculate_relocation[XCOFF_MAX_CALCULATE_RELOCATION] =
++xcoff_reloc_function *const xcoff64_calculate_relocation[] =
+ {
+   xcoff_reloc_type_pos,  /* R_POS     (0x00) */
+   xcoff_reloc_type_neg,  /* R_NEG     (0x01) */
+@@ -1415,8 +1414,11 @@ reloc_howto_type xcoff64_howto_table[] =
+ void
+ xcoff64_rtype2howto (arelent *relent, struct internal_reloc *internal)
+ {
+-  if (internal->r_type > R_TOCL)
+-    abort ();
++  if (internal->r_type >= ARRAY_SIZE (xcoff64_howto_table))
++    {
++      relent->howto = NULL;
++      return;
++    }
+ 
+   /* Default howto layout works most of the time */
+   relent->howto = &xcoff64_howto_table[internal->r_type];
+@@ -1449,7 +1451,7 @@ xcoff64_rtype2howto (arelent *relent, struct internal_reloc *internal)
+   if (relent->howto->dst_mask != 0
+       && (relent->howto->bitsize
+ 	  != ((unsigned int) internal->r_size & 0x3f) + 1))
+-    abort ();
++    relent->howto = NULL;
+ }
+ 
+ reloc_howto_type *
+@@ -1504,9 +1506,7 @@ xcoff64_reloc_name_lookup (bfd *abfd ATTRIBUTE_UNUSED,
+ {
+   unsigned int i;
+ 
+-  for (i = 0;
+-       i < sizeof (xcoff64_howto_table) / sizeof (xcoff64_howto_table[0]);
+-       i++)
++  for (i = 0; i < ARRAY_SIZE (xcoff64_howto_table); i++)
+     if (xcoff64_howto_table[i].name != NULL
+ 	&& strcasecmp (xcoff64_howto_table[i].name, r_name) == 0)
+       return &xcoff64_howto_table[i];
+@@ -1550,6 +1550,14 @@ xcoff64_ppc_relocate_section (bfd *output_bfd,
+ 	 the csect including the symbol which it references.  */
+       if (rel->r_type == R_REF)
+ 	continue;
++      if (rel->r_type >= ARRAY_SIZE (xcoff64_howto_table))
++       {
++         /* xgettext:c-format */
++         _bfd_error_handler (_("%pB: unsupported relocation type %#x"),
++                             input_bfd, rel->r_type);
++         bfd_set_error (bfd_error_bad_value);
++         return false;
++       }
+ 
+       /* Retrieve default value in HOWTO table and fix up according
+ 	 to r_size field, if it can be different.
+@@ -1569,7 +1577,7 @@ xcoff64_ppc_relocate_section (bfd *output_bfd,
+ 
+ 	    default:
+ 	      _bfd_error_handler
+-		(_("%pB: relocation (%d) at (0x%" BFD_VMA_FMT "x) has wrong"
++		(_("%pB: relocation (%#x) at (0x%" BFD_VMA_FMT "x) has wrong"
+ 		   " r_rsize (0x%x)\n"),
+ 		 input_bfd, rel->r_type, rel->r_vaddr, rel->r_size);
+ 	      return false;
+@@ -1642,10 +1650,9 @@ xcoff64_ppc_relocate_section (bfd *output_bfd,
+ 	    }
+ 	}
+ 
+-      if (rel->r_type >= XCOFF_MAX_CALCULATE_RELOCATION
+-	  || !((*xcoff64_calculate_relocation[rel->r_type])
+-	      (input_bfd, input_section, output_bfd, rel, sym, &howto, val,
+-	       addend, &relocation, contents)))
++      if (!((*xcoff64_calculate_relocation[rel->r_type])
++	   (input_bfd, input_section, output_bfd, rel, sym, &howto, val,
++	    addend, &relocation, contents)))
+ 	return false;
+ 
+       /* address */
+diff --git a/bfd/libxcoff.h b/bfd/libxcoff.h
+index 2a71ee58..9e816de0 100644
+--- a/bfd/libxcoff.h
++++ b/bfd/libxcoff.h
+@@ -201,9 +201,6 @@ struct xcoff_backend_data_rec
+ #define bfd_xcoff_text_align_power(a) ((xcoff_data (a)->text_align_power))
+ #define bfd_xcoff_data_align_power(a) ((xcoff_data (a)->data_align_power))
+ 
+-/* xcoff*_ppc_relocate_section macros  */
+-#define XCOFF_MAX_CALCULATE_RELOCATION (0x32)
+-#define XCOFF_MAX_COMPLAIN_OVERFLOW (4)
+ /* N_ONES produces N one bits, without overflowing machine arithmetic.  */
+ #ifdef N_ONES
+ #undef N_ONES
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-devtools/binutils/binutils_%.bbappend b/meta-core/recipes-devtools/binutils/binutils_%.bbappend
new file mode 100644
index 0000000..df278ce
--- /dev/null
+++ b/meta-core/recipes-devtools/binutils/binutils_%.bbappend
@@ -0,0 +1,6 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+SRC_URI += "file://CVE-2025-69649.patch \
+            file://CVE-2025-69652.patch \
+            file://CVE-2026-4647.patch \
+"
-- 
2.34.1


