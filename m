Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DBC25B74
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 00:36:12 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.731.1717115767515657377
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 May 2024 17:36:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T1eg7poX;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a08b250a2so14767677b3.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 30 May 2024 17:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717115766; x=1717720566; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V+MNzLjd3U8g2M/bxW0onPFFydXlgbNNcpCdVElnAtg=;
        b=T1eg7poXAiJjQ4QNHfO8tIzmHlQq+rFreHBXWstrh/WoF2UdaiSu1fVqvA734ObuVG
         S0jy6R5MYpbbWDh86fe7KhC4hMTDsovuK9P2mo7KWLkMnuPj2drkmVZb5YomO+xtHana
         F5tRi5Lpbgp2+lA4/z1l/BTLyz0vM8+Y72dnucPHwGQEC4NhChDfn1TcRAjzTO8Loomd
         wm8nrqT3pxCld79TVOweSvr0aPZQ3pXhgRn0hd9oFcsQWVGtLWCSJUA6nt5HLwLPDhBj
         YK5/9MyVFUj5dBuyC7gxakmyP5LcamMzD2+Z5qmD3t2MqZNXddtP7za9fJhKCogY5Vtl
         366g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717115766; x=1717720566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+MNzLjd3U8g2M/bxW0onPFFydXlgbNNcpCdVElnAtg=;
        b=LZkxlp/RVOSkcvXakSKDZ2baHGQQop1AQN3Ukg0kH/h5/aRXYkaXqmZCYk9go/gDbS
         JLOgelmSB5pmn7xw1DtQCM3SLfKFAgr3TJOVif+Z8YVE9u1KW9iI2yTNTqfnOd+nSzNa
         f2ReAkdWgzPhRJeNf51f6kCorjMbyw22Td7eXsF8ajCnC2Y/g2+nyduNZ1OmS1nINUYv
         obx1G5n6IJv0EVPfAZSDIgliBY52lrnAoZDbh+Q4B1inVnyiELqR4hybuRfXOiBl3GGo
         E8jA24CDGYRavA3Z/pS9HJaQptukZ16ekiQNeD6g5BRDrrCmax68eM81y7OBlH+z1YGZ
         G+LA==
X-Gm-Message-State: AOJu0YzAZY+NDKngbYjAxqrZoAUViFIreVDwP2AaULA/Td7UX4XadTZf
	TFPv+n9X9l+8GoVWdtSO+l55YNep5on9exSDMPIJ6Zgl0Nv6k4q21K4YY5fjNqL72LUgox/TeE1
	IAfpsaO1DigEbP200e2Yvkp1M6UxWzA==
X-Google-Smtp-Source: AGHT+IHXtRkMxgY6mH0y6RpZR2A0jxbToKnZlIfnMgeifhgLrpbTivUK+uIGU9kM5INPrypqH/l5dCU65sjMudbFBPI=
X-Received: by 2002:a81:4304:0:b0:61a:ae79:816a with SMTP id
 00721157ae682-62c796c56famr3821837b3.31.1717115765890; Thu, 30 May 2024
 17:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240527091740.343852-1-andrej.kozemcak@siemens.com>
In-Reply-To: <20240527091740.343852-1-andrej.kozemcak@siemens.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Thu, 30 May 2024 17:35:54 -0700
Message-ID: <CANx9H-BYN8uPXYj=GAWMQKFzRfq_FdgNdGi7AgSf6=Kz0E=gdw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-java][PATCH] openjdk-8: improve patch for
 different architecure
To: yocto-patches@lists.yoctoproject.org
Cc: Andrej Kozemcak <andrej.kozemcak@siemens.com>
Content-Type: multipart/alternative; boundary="00000000000043a7100619b52bc9"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 00:36:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/249

--00000000000043a7100619b52bc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

See comment below. Upstream-Status: Backport should include information
about where the backport exists.

On Mon, May 27, 2024 at 2:18=E2=80=AFAM Andrej Kozemcak via lists.yoctoproj=
ect.org
<andrej.kozemcak=3Dsiemens.com@lists.yoctoproject.org> wrote:

> Arrch64 and arm use same patch for different code. Improve
> patch for arm code, so it can be apply without any warnings.
>
> Signed-off-by: Andrej Kozemcak <andrej.kozemcak@siemens.com>
> ---
>  .../openjdk/openjdk-8-release-common.inc      |  12 +-
>  ...h32-Turn-on-the-Wreturn-type-warning.patch | 237 ++++++++++++++++++
>  ...64-Turn-on-the-Wreturn-type-warning.patch} |   0
>  3 files changed, 246 insertions(+), 3 deletions(-)
>  create mode 100644
> recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-the-W=
return-type-warning.patch
>  rename
> recipes-core/openjdk/patches-openjdk-8/{1007-hotspot-Turn-on-the-Wreturn-=
type-warning.patch
> =3D> 1007-hotspot-aarch64-Turn-on-the-Wreturn-type-warning.patch} (100%)
>
> diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc
> b/recipes-core/openjdk/openjdk-8-release-common.inc
> index ff8d96e..8ef7049 100644
> --- a/recipes-core/openjdk/openjdk-8-release-common.inc
> +++ b/recipes-core/openjdk/openjdk-8-release-common.inc
> @@ -29,7 +29,6 @@ HOTSPOT_UB_PATCH =3D "\
>
>  file://1004-hotspot-fix-Wreturn-type-issues-introduced-by-806165.patch \
>      file://1005-hotspot-Zero-build-requires-disabled-warnings.patch \
>
>  file://1006-hotspot-Missing-return-statement-in-__sync_val_compa.patch \
> -    file://1007-hotspot-Turn-on-the-Wreturn-type-warning.patch \
>      file://1008-hotspot-handle-format-error-for-GCC-7.patch \
>      file://1012-hotspot-enable-Wno-error.patch \
>  "
> @@ -39,10 +38,17 @@ HOTSPOT_UB_PATCH:append:class-target =3D "\
>      file://1011-hotspot-restrict-to-staging-dir.patch \
>  "
>  HOTSPOT_UB_PATCH:prepend:aarch64 =3D "\
> +    file://1007-hotspot-aarch64-Turn-on-the-Wreturn-type-warning.patch \
>
>  file://1401-hotspot-aarch64-Add-missing-return-value-to-LIR_Asse.patch \
>  "
> -HOTSPOT_UB_PATCH:append:armv7a =3D "
> file://1201-hotspot-aarch32-fix-missing-return-values.patch"
> -HOTSPOT_UB_PATCH:append:armv7ve =3D "
> file://1201-hotspot-aarch32-fix-missing-return-values.patch"
> +HOTSPOT_UB_PATCH:append:armv7a =3D "\
> +    file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch \
> +    file://1201-hotspot-aarch32-fix-missing-return-values.patch \
> +"
> +HOTSPOT_UB_PATCH:append:armv7ve =3D "\
> +    file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch \
> +    file://1201-hotspot-aarch32-fix-missing-return-values.patch \
> +"
>
>  PATCHES_URI:append:class-target =3D "\
>      file://1013-hotspot-add-missing-includes-for-shark-build-pt2.patch \
> diff --git
> a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-the=
-Wreturn-type-warning.patch
> b/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-the=
-Wreturn-type-warning.patch
> new file mode 100644
> index 0000000..ecd610c
> --- /dev/null
> +++
> b/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-the=
-Wreturn-type-warning.patch
> @@ -0,0 +1,237 @@
> +From 6758bf27e31110dc5d4c7237476c823ff05454a2 Mon Sep 17 00:00:00 2001
> +From: Richard Leitner <richard.leitner@skidata.com>
> +Date: Thu, 22 Oct 2020 09:41:07 +0200
> +Subject: [PATCH] hotspot: Turn on the -Wreturn-type warning
> +MIME-Version: 1.0
> +Content-Type: text/plain; charset=3DUTF-8
> +Content-Transfer-Encoding: 8bit
> +
> +MIME-Version: 1.0
> +Content-Type: text/plain; charset=3DUTF-8
> +Content-Transfer-Encoding: 8bit
> +
> +|# HG changeset patch
> +|# User stefank
> +|# Date 1525453613 -3600
> +|#      Fri May 04 18:06:53 2018 +0100
> +|# Node ID 07a1135a327362f157955d470fad5df07cc35164
> +|# Parent  de79964656fc652f2085dac4fe99bcc128b5a3b1
> +8062808, PR3548: Turn on the -Wreturn-type warning
> +Reviewed-by: mgerdin, tschatzl, coleenp, jrose, kbarrett
> +
> +Upstream-Status: Backport
>

Backport should include a link to the commit/patch in []


> +
> +Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@jci.com>
> +Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> +
> +---
> + hotspot/make/linux/makefiles/gcc.make               | 2 +-
> + hotspot/src/cpu/x86/vm/x86_32.ad                    | 1 +
> + hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp    | 1 +
> + hotspot/src/share/vm/classfile/defaultMethods.cpp   | 4 ++--
> + hotspot/src/share/vm/classfile/symbolTable.cpp      | 4 ++--
> + hotspot/src/share/vm/classfile/systemDictionary.cpp | 6 +++---
> + hotspot/src/share/vm/memory/heapInspection.hpp      | 2 +-
> + hotspot/src/share/vm/memory/metaspaceShared.hpp     | 2 +-
> + hotspot/src/share/vm/oops/constantPool.hpp          | 2 +-
> + hotspot/src/share/vm/prims/jvm.cpp                  | 2 +-
> + hotspot/src/share/vm/runtime/reflection.cpp         | 2 +-
> + hotspot/src/share/vm/runtime/sharedRuntime.cpp      | 2 +-
> + hotspot/src/share/vm/services/memTracker.hpp        | 2 +-
> + 13 files changed, 17 insertions(+), 15 deletions(-)
> +
> +diff --git a/hotspot/make/linux/makefiles/gcc.make
> b/hotspot/make/linux/makefiles/gcc.make
> +index 76f738c6..67607fb2 100644
> +--- a/hotspot/make/linux/makefiles/gcc.make
> ++++ b/hotspot/make/linux/makefiles/gcc.make
> +@@ -212,7 +212,7 @@ ifeq ($(USE_CLANG), true)
> +   WARNINGS_ARE_ERRORS +=3D -Wno-return-type -Wno-empty-body
> + endif
> +
> +-WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-funct=
ion
> -Wunused-value
> ++WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-funct=
ion
> -Wunused-value -Wreturn-type
> +
> + ifeq ($(USE_CLANG),)
> +   # Since GCC 4.3, -Wconversion has changed its meanings to warn these
> implicit
> +diff --git a/hotspot/src/cpu/x86/vm/x86_32.ad b/hotspot/src/cpu/x86/vm/
> x86_32.ad
> +index f42d1a28..c8f4ee16 100644
> +--- a/hotspot/src/cpu/x86/vm/x86_32.ad
> ++++ b/hotspot/src/cpu/x86/vm/x86_32.ad
> +@@ -1250,6 +1250,7 @@ uint MachSpillCopyNode::implementation( CodeBuffer
> *cbuf, PhaseRegAlloc *ra_, bo
> +
> +
> +   Unimplemented();
> ++  return 0; // Mute compiler
> + }
> +
> + #ifndef PRODUCT
> +diff --git a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
> b/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
> +index c35d8677..65c3165c 100644
> +--- a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
> ++++ b/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp
> +@@ -541,6 +541,7 @@ JVM_handle_linux_signal(int sig,
> +   err.report_and_die();
> +
> +   ShouldNotReachHere();
> ++  return true; // Mute compiler
> + }
> +
> + void os::Linux::init_thread_fpu_state(void) {
> +diff --git a/hotspot/src/share/vm/classfile/defaultMethods.cpp
> b/hotspot/src/share/vm/classfile/defaultMethods.cpp
> +index 4b4b4e25..196622ae 100644
> +--- a/hotspot/src/share/vm/classfile/defaultMethods.cpp
> ++++ b/hotspot/src/share/vm/classfile/defaultMethods.cpp
> +@@ -506,7 +506,7 @@ Symbol* MethodFamily::generate_method_message(Symbol
> *klass_name, Method* method
> +   ss.write((const char*)name->bytes(), name->utf8_length());
> +   ss.write((const char*)signature->bytes(), signature->utf8_length());
> +   ss.print(" is abstract");
> +-  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NULL)=
;
> ++  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);
> + }
> +
> + Symbol* MethodFamily::generate_conflicts_message(GrowableArray<Method*>=
*
> methods, TRAPS) const {
> +@@ -521,7 +521,7 @@ Symbol*
> MethodFamily::generate_conflicts_message(GrowableArray<Method*>* methods
> +     ss.print(".");
> +     ss.write((const char*)name->bytes(), name->utf8_length());
> +   }
> +-  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NULL)=
;
> ++  return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);
> + }
> +
> +
> +diff --git a/hotspot/src/share/vm/classfile/symbolTable.cpp
> b/hotspot/src/share/vm/classfile/symbolTable.cpp
> +index ec97077b..2621a7d6 100644
> +--- a/hotspot/src/share/vm/classfile/symbolTable.cpp
> ++++ b/hotspot/src/share/vm/classfile/symbolTable.cpp
> +@@ -249,7 +249,7 @@ Symbol* SymbolTable::lookup(const char* name, int
> len, TRAPS) {
> +   MutexLocker ml(SymbolTable_lock, THREAD);
> +
> +   // Otherwise, add to symbol to table
> +-  return the_table()->basic_add(index, (u1*)name, len, hashValue, true,
> CHECK_NULL);
> ++  return the_table()->basic_add(index, (u1*)name, len, hashValue, true,
> THREAD);
> + }
> +
> + Symbol* SymbolTable::lookup(const Symbol* sym, int begin, int end,
> TRAPS) {
> +@@ -288,7 +288,7 @@ Symbol* SymbolTable::lookup(const Symbol* sym, int
> begin, int end, TRAPS) {
> +   // Grab SymbolTable_lock first.
> +   MutexLocker ml(SymbolTable_lock, THREAD);
> +
> +-  return the_table()->basic_add(index, (u1*)buffer, len, hashValue,
> true, CHECK_NULL);
> ++  return the_table()->basic_add(index, (u1*)buffer, len, hashValue,
> true, THREAD);
> + }
> +
> + Symbol* SymbolTable::lookup_only(const char* name, int len,
> +diff --git a/hotspot/src/share/vm/classfile/systemDictionary.cpp
> b/hotspot/src/share/vm/classfile/systemDictionary.cpp
> +index 3e64b719..b1dd335c 100644
> +--- a/hotspot/src/share/vm/classfile/systemDictionary.cpp
> ++++ b/hotspot/src/share/vm/classfile/systemDictionary.cpp
> +@@ -236,15 +236,15 @@ Klass* SystemDictionary::resolve_or_null(Symbol*
> class_name, Handle class_loader
> +                  class_name->as_C_string(),
> +                  class_loader.is_null() ? "null" :
> class_loader->klass()->name()->as_C_string()));
> +   if (FieldType::is_array(class_name)) {
> +-    return resolve_array_class_or_null(class_name, class_loader,
> protection_domain, CHECK_NULL);
> ++    return resolve_array_class_or_null(class_name, class_loader,
> protection_domain, THREAD);
> +   } else if (FieldType::is_obj(class_name)) {
> +     ResourceMark rm(THREAD);
> +     // Ignore wrapping L and ;.
> +     TempNewSymbol name =3D
> SymbolTable::new_symbol(class_name->as_C_string() + 1,
> +                                    class_name->utf8_length() - 2,
> CHECK_NULL);
> +-    return resolve_instance_class_or_null(name, class_loader,
> protection_domain, CHECK_NULL);
> ++    return resolve_instance_class_or_null(name, class_loader,
> protection_domain, THREAD);
> +   } else {
> +-    return resolve_instance_class_or_null(class_name, class_loader,
> protection_domain, CHECK_NULL);
> ++    return resolve_instance_class_or_null(class_name, class_loader,
> protection_domain, THREAD);
> +   }
> + }
> +
> +diff --git a/hotspot/src/share/vm/memory/heapInspection.hpp
> b/hotspot/src/share/vm/memory/heapInspection.hpp
> +index 09ee6602..c5fec15c 100644
> +--- a/hotspot/src/share/vm/memory/heapInspection.hpp
> ++++ b/hotspot/src/share/vm/memory/heapInspection.hpp
> +@@ -367,7 +367,7 @@ class HeapInspection : public StackObj {
> +       _csv_format(csv_format), _print_help(print_help),
> +       _print_class_stats(print_class_stats), _columns(columns) {}
> +   void heap_inspection(outputStream* st) NOT_SERVICES_RETURN;
> +-  size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filter =
=3D
> NULL) NOT_SERVICES_RETURN;
> ++  size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filter =
=3D
> NULL) NOT_SERVICES_RETURN_(0);
> +   static void find_instances_at_safepoint(Klass* k, GrowableArray<oop>*
> result) NOT_SERVICES_RETURN;
> +  private:
> +   void iterate_over_heap(KlassInfoTable* cit, BoolObjectClosure* filter
> =3D NULL);
> +diff --git a/hotspot/src/share/vm/memory/metaspaceShared.hpp
> b/hotspot/src/share/vm/memory/metaspaceShared.hpp
> +index 2f3abae6..d58ebecb 100644
> +--- a/hotspot/src/share/vm/memory/metaspaceShared.hpp
> ++++ b/hotspot/src/share/vm/memory/metaspaceShared.hpp
> +@@ -93,7 +93,7 @@ class MetaspaceShared : AllStatic {
> +   static void preload_and_dump(TRAPS) NOT_CDS_RETURN;
> +   static int preload_and_dump(const char * class_list_path,
> +                               GrowableArray<Klass*>* class_promote_orde=
r,
> +-                              TRAPS) NOT_CDS_RETURN;
> ++                              TRAPS) NOT_CDS_RETURN_(0);
> +
> +   static ReservedSpace* shared_rs() {
> +     CDS_ONLY(return _shared_rs);
> +diff --git a/hotspot/src/share/vm/oops/constantPool.hpp
> b/hotspot/src/share/vm/oops/constantPool.hpp
> +index 124c970e..dae574c0 100644
> +--- a/hotspot/src/share/vm/oops/constantPool.hpp
> ++++ b/hotspot/src/share/vm/oops/constantPool.hpp
> +@@ -353,7 +353,7 @@ class ConstantPool : public Metadata {
> +
> +   Klass* klass_at(int which, TRAPS) {
> +     constantPoolHandle h_this(THREAD, this);
> +-    return klass_at_impl(h_this, which, CHECK_NULL);
> ++    return klass_at_impl(h_this, which, THREAD);
> +   }
> +
> +   Symbol* klass_name_at(int which);  // Returns the name, w/o resolving=
.
> +diff --git a/hotspot/src/share/vm/prims/jvm.cpp
> b/hotspot/src/share/vm/prims/jvm.cpp
> +index 6f2221c4..daa69f89 100644
> +--- a/hotspot/src/share/vm/prims/jvm.cpp
> ++++ b/hotspot/src/share/vm/prims/jvm.cpp
> +@@ -4368,7 +4368,7 @@ JVM_ENTRY(jlong,JVM_DTraceActivate(
> +     JVM_DTraceProvider* providers))
> +   JVMWrapper("JVM_DTraceActivate");
> +   return DTraceJSDT::activate(
> +-    version, module_name, providers_count, providers, CHECK_0);
> ++    version, module_name, providers_count, providers, THREAD);
> + JVM_END
> +
> + JVM_ENTRY(jboolean,JVM_DTraceIsProbeEnabled(JNIEnv* env, jmethodID
> method))
> +diff --git a/hotspot/src/share/vm/runtime/reflection.cpp
> b/hotspot/src/share/vm/runtime/reflection.cpp
> +index d9fddbe4..a5f73793 100644
> +--- a/hotspot/src/share/vm/runtime/reflection.cpp
> ++++ b/hotspot/src/share/vm/runtime/reflection.cpp
> +@@ -1093,7 +1093,7 @@ oop Reflection::invoke(instanceKlassHandle klass,
> methodHandle reflected_method,
> +   } else {
> +     if (rtype =3D=3D T_BOOLEAN || rtype =3D=3D T_BYTE || rtype =3D=3D T=
_CHAR ||
> rtype =3D=3D T_SHORT)
> +       narrow((jvalue*) result.get_value_addr(), rtype, CHECK_NULL);
> +-    return box((jvalue*) result.get_value_addr(), rtype, CHECK_NULL);
> ++    return box((jvalue*) result.get_value_addr(), rtype, THREAD);
> +   }
> + }
> +
> +diff --git a/hotspot/src/share/vm/runtime/sharedRuntime.cpp
> b/hotspot/src/share/vm/runtime/sharedRuntime.cpp
> +index 013aa7a2..df4cde96 100644
> +--- a/hotspot/src/share/vm/runtime/sharedRuntime.cpp
> ++++ b/hotspot/src/share/vm/runtime/sharedRuntime.cpp
> +@@ -1045,7 +1045,7 @@ Handle SharedRuntime::find_callee_info(JavaThread*
> thread, Bytecodes::Code& bc,
> +   // last java frame on stack (which includes native call frames)
> +   vframeStream vfst(thread, true);  // Do not skip and javaCalls
> +
> +-  return find_callee_info_helper(thread, vfst, bc, callinfo,
> CHECK_(Handle()));
> ++  return find_callee_info_helper(thread, vfst, bc, callinfo, THREAD);
> + }
> +
> +
> +diff --git a/hotspot/src/share/vm/services/memTracker.hpp
> b/hotspot/src/share/vm/services/memTracker.hpp
> +index 8ea859dd..535147f8 100644
> +--- a/hotspot/src/share/vm/services/memTracker.hpp
> ++++ b/hotspot/src/share/vm/services/memTracker.hpp
> +@@ -64,7 +64,7 @@ class MemTracker : AllStatic {
> +     const NativeCallStack& stack, MEMFLAGS flag =3D mtNone) { }
> +   static inline void record_virtual_memory_commit(void* addr, size_t
> size, const NativeCallStack& stack) { }
> +   static inline Tracker get_virtual_memory_uncommit_tracker() { return
> Tracker(); }
> +-  static inline Tracker get_virtual_memory_release_tracker() { }
> ++  static inline Tracker get_virtual_memory_release_tracker() { return
> Tracker(); }
> +   static inline void record_virtual_memory_type(void* addr, MEMFLAGS
> flag) { }
> +   static inline void record_thread_stack(void* addr, size_t size) { }
> +   static inline void release_thread_stack(void* addr, size_t size) { }
> diff --git
> a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-the-Wreturn=
-type-warning.patch
> b/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch64-Turn-on-the=
-Wreturn-type-warning.patch
> similarity index 100%
> rename from
> recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-the-Wreturn-t=
ype-warning.patch
> rename to
> recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch64-Turn-on-the-W=
return-type-warning.patch
> --
> 2.39.2
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#209):
> https://lists.yoctoproject.org/g/yocto-patches/message/209
> Mute This Topic: https://lists.yoctoproject.org/mt/106327342/924729
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/1023=
951714/xyzzy
> [ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--00000000000043a7100619b52bc9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>See comment below. Upstream-Status: Backport should i=
nclude information about where the backport exists.</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at =
2:18=E2=80=AFAM Andrej Kozemcak via <a href=3D"http://lists.yoctoproject.or=
g">lists.yoctoproject.org</a> &lt;andrej.kozemcak=3D<a href=3D"mailto:sieme=
ns.com@lists.yoctoproject.org">siemens.com@lists.yoctoproject.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Arrch64 an=
d arm use same patch for different code. Improve<br>
patch for arm code, so it can be apply without any warnings.<br>
<br>
Signed-off-by: Andrej Kozemcak &lt;<a href=3D"mailto:andrej.kozemcak@siemen=
s.com" target=3D"_blank">andrej.kozemcak@siemens.com</a>&gt;<br>
---<br>
=C2=A0.../openjdk/openjdk-8-release-common.inc=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
12 +-<br>
=C2=A0...h32-Turn-on-the-Wreturn-type-warning.patch | 237 +++++++++++++++++=
+<br>
=C2=A0...64-Turn-on-the-Wreturn-type-warning.patch} |=C2=A0 =C2=A00<br>
=C2=A03 files changed, 246 insertions(+), 3 deletions(-)<br>
=C2=A0create mode 100644 recipes-core/openjdk/patches-openjdk-8/1007-hotspo=
t-aarch32-Turn-on-the-Wreturn-type-warning.patch<br>
=C2=A0rename recipes-core/openjdk/patches-openjdk-8/{1007-hotspot-Turn-on-t=
he-Wreturn-type-warning.patch =3D&gt; 1007-hotspot-aarch64-Turn-on-the-Wret=
urn-type-warning.patch} (100%)<br>
<br>
diff --git a/recipes-core/openjdk/openjdk-8-release-common.inc b/recipes-co=
re/openjdk/openjdk-8-release-common.inc<br>
index ff8d96e..8ef7049 100644<br>
--- a/recipes-core/openjdk/openjdk-8-release-common.inc<br>
+++ b/recipes-core/openjdk/openjdk-8-release-common.inc<br>
@@ -29,7 +29,6 @@ HOTSPOT_UB_PATCH =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://1004-hotspot-fix-Wreturn-type-issues-introduced-=
by-806165.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://1005-hotspot-Zero-build-requires-disabled-warnin=
gs.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://1006-hotspot-Missing-return-statement-in-__sync_=
val_compa.patch \<br>
-=C2=A0 =C2=A0 file://1007-hotspot-Turn-on-the-Wreturn-type-warning.patch \=
<br>
=C2=A0 =C2=A0 =C2=A0file://1008-hotspot-handle-format-error-for-GCC-7.patch=
 \<br>
=C2=A0 =C2=A0 =C2=A0file://1012-hotspot-enable-Wno-error.patch \<br>
=C2=A0&quot;<br>
@@ -39,10 +38,17 @@ HOTSPOT_UB_PATCH:append:class-target =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://1011-hotspot-restrict-to-staging-dir.patch \<br>
=C2=A0&quot;<br>
=C2=A0HOTSPOT_UB_PATCH:prepend:aarch64 =3D &quot;\<br>
+=C2=A0 =C2=A0 file://1007-hotspot-aarch64-Turn-on-the-Wreturn-type-warning=
.patch \<br>
=C2=A0 =C2=A0 =C2=A0file://1401-hotspot-aarch64-Add-missing-return-value-to=
-LIR_Asse.patch \<br>
=C2=A0&quot;<br>
-HOTSPOT_UB_PATCH:append:armv7a =3D &quot; file://1201-hotspot-aarch32-fix-=
missing-return-values.patch&quot;<br>
-HOTSPOT_UB_PATCH:append:armv7ve =3D &quot; file://1201-hotspot-aarch32-fix=
-missing-return-values.patch&quot;<br>
+HOTSPOT_UB_PATCH:append:armv7a =3D &quot;\<br>
+=C2=A0 =C2=A0 file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning=
.patch \<br>
+=C2=A0 =C2=A0 file://1201-hotspot-aarch32-fix-missing-return-values.patch =
\<br>
+&quot;<br>
+HOTSPOT_UB_PATCH:append:armv7ve =3D &quot;\<br>
+=C2=A0 =C2=A0 file://1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning=
.patch \<br>
+=C2=A0 =C2=A0 file://1201-hotspot-aarch32-fix-missing-return-values.patch =
\<br>
+&quot;<br>
<br>
=C2=A0PATCHES_URI:append:class-target =3D &quot;\<br>
=C2=A0 =C2=A0 =C2=A0file://1013-hotspot-add-missing-includes-for-shark-buil=
d-pt2.patch \<br>
diff --git a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Tu=
rn-on-the-Wreturn-type-warning.patch b/recipes-core/openjdk/patches-openjdk=
-8/1007-hotspot-aarch32-Turn-on-the-Wreturn-type-warning.patch<br>
new file mode 100644<br>
index 0000000..ecd610c<br>
--- /dev/null<br>
+++ b/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch32-Turn-on-t=
he-Wreturn-type-warning.patch<br>
@@ -0,0 +1,237 @@<br>
+From 6758bf27e31110dc5d4c7237476c823ff05454a2 Mon Sep 17 00:00:00 2001<br>
+From: Richard Leitner &lt;<a href=3D"mailto:richard.leitner@skidata.com" t=
arget=3D"_blank">richard.leitner@skidata.com</a>&gt;<br>
+Date: Thu, 22 Oct 2020 09:41:07 +0200<br>
+Subject: [PATCH] hotspot: Turn on the -Wreturn-type warning<br>
+MIME-Version: 1.0<br>
+Content-Type: text/plain; charset=3DUTF-8<br>
+Content-Transfer-Encoding: 8bit<br>
+<br>
+MIME-Version: 1.0<br>
+Content-Type: text/plain; charset=3DUTF-8<br>
+Content-Transfer-Encoding: 8bit<br>
+<br>
+|# HG changeset patch<br>
+|# User stefank<br>
+|# Date 1525453613 -3600<br>
+|#=C2=A0 =C2=A0 =C2=A0 Fri May 04 18:06:53 2018 +0100<br>
+|# Node ID 07a1135a327362f157955d470fad5df07cc35164<br>
+|# Parent=C2=A0 de79964656fc652f2085dac4fe99bcc128b5a3b1<br>
+8062808, PR3548: Turn on the -Wreturn-type warning<br>
+Reviewed-by: mgerdin, tschatzl, coleenp, jrose, kbarrett<br>
+<br>
+Upstream-Status: Backport<br></blockquote><div><br></div><div>Backport sho=
uld include a link to the commit/patch in []</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+<br>
+Signed-off-by: Andr=C3=A9 Draszik &lt;<a href=3D"mailto:andre.draszik@jci.=
com" target=3D"_blank">andre.draszik@jci.com</a>&gt;<br>
+Signed-off-by: Richard Leitner &lt;<a href=3D"mailto:richard.leitner@skida=
ta.com" target=3D"_blank">richard.leitner@skidata.com</a>&gt;<br>
+<br>
+---<br>
+ hotspot/make/linux/makefiles/gcc.make=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
+ hotspot/src/cpu/x86/vm/<a href=3D"http://x86_32.ad" rel=3D"noreferrer" ta=
rget=3D"_blank">x86_32.ad</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
+ hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp=C2=A0 =C2=A0 | 1 +<br>
+ hotspot/src/share/vm/classfile/defaultMethods.cpp=C2=A0 =C2=A0| 4 ++--<br=
>
+ hotspot/src/share/vm/classfile/symbolTable.cpp=C2=A0 =C2=A0 =C2=A0 | 4 ++=
--<br>
+ hotspot/src/share/vm/classfile/systemDictionary.cpp | 6 +++---<br>
+ hotspot/src/share/vm/memory/heapInspection.hpp=C2=A0 =C2=A0 =C2=A0 | 2 +-=
<br>
+ hotspot/src/share/vm/memory/metaspaceShared.hpp=C2=A0 =C2=A0 =C2=A0| 2 +-=
<br>
+ hotspot/src/share/vm/oops/constantPool.hpp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 2 +-<br>
+ hotspot/src/share/vm/prims/jvm.cpp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
+ hotspot/src/share/vm/runtime/reflection.cpp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 2 +-<br>
+ hotspot/src/share/vm/runtime/sharedRuntime.cpp=C2=A0 =C2=A0 =C2=A0 | 2 +-=
<br>
+ hotspot/src/share/vm/services/memTracker.hpp=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 2 +-<br>
+ 13 files changed, 17 insertions(+), 15 deletions(-)<br>
+<br>
+diff --git a/hotspot/make/linux/makefiles/gcc.make b/hotspot/make/linux/ma=
kefiles/gcc.make<br>
+index 76f738c6..67607fb2 100644<br>
+--- a/hotspot/make/linux/makefiles/gcc.make<br>
++++ b/hotspot/make/linux/makefiles/gcc.make<br>
+@@ -212,7 +212,7 @@ ifeq ($(USE_CLANG), true)<br>
+=C2=A0 =C2=A0WARNINGS_ARE_ERRORS +=3D -Wno-return-type -Wno-empty-body<br>
+ endif<br>
+ <br>
+-WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-functio=
n -Wunused-value<br>
++WARNING_FLAGS =3D -Wpointer-arith -Wsign-compare -Wundef -Wunused-functio=
n -Wunused-value -Wreturn-type<br>
+ <br>
+ ifeq ($(USE_CLANG),)<br>
+=C2=A0 =C2=A0# Since GCC 4.3, -Wconversion has changed its meanings to war=
n these implicit<br>
+diff --git a/hotspot/src/cpu/x86/vm/<a href=3D"http://x86_32.ad" rel=3D"no=
referrer" target=3D"_blank">x86_32.ad</a> b/hotspot/src/cpu/x86/vm/<a href=
=3D"http://x86_32.ad" rel=3D"noreferrer" target=3D"_blank">x86_32.ad</a><br=
>
+index f42d1a28..c8f4ee16 100644<br>
+--- a/hotspot/src/cpu/x86/vm/<a href=3D"http://x86_32.ad" rel=3D"noreferre=
r" target=3D"_blank">x86_32.ad</a><br>
++++ b/hotspot/src/cpu/x86/vm/<a href=3D"http://x86_32.ad" rel=3D"noreferre=
r" target=3D"_blank">x86_32.ad</a><br>
+@@ -1250,6 +1250,7 @@ uint MachSpillCopyNode::implementation( CodeBuffer *=
cbuf, PhaseRegAlloc *ra_, bo<br>
+ <br>
+ <br>
+=C2=A0 =C2=A0Unimplemented();<br>
++=C2=A0 return 0; // Mute compiler<br>
+ }<br>
+ <br>
+ #ifndef PRODUCT<br>
+diff --git a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp b/hotspot/sr=
c/os_cpu/linux_x86/vm/os_linux_x86.cpp<br>
+index c35d8677..65c3165c 100644<br>
+--- a/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp<br>
++++ b/hotspot/src/os_cpu/linux_x86/vm/os_linux_x86.cpp<br>
+@@ -541,6 +541,7 @@ JVM_handle_linux_signal(int sig,<br>
+=C2=A0 =C2=A0err.report_and_die();<br>
+ <br>
+=C2=A0 =C2=A0ShouldNotReachHere();<br>
++=C2=A0 return true; // Mute compiler<br>
+ }<br>
+ <br>
+ void os::Linux::init_thread_fpu_state(void) {<br>
+diff --git a/hotspot/src/share/vm/classfile/defaultMethods.cpp b/hotspot/s=
rc/share/vm/classfile/defaultMethods.cpp<br>
+index 4b4b4e25..196622ae 100644<br>
+--- a/hotspot/src/share/vm/classfile/defaultMethods.cpp<br>
++++ b/hotspot/src/share/vm/classfile/defaultMethods.cpp<br>
+@@ -506,7 +506,7 @@ Symbol* MethodFamily::generate_method_message(Symbol *=
klass_name, Method* method<br>
+=C2=A0 =C2=A0ss.write((const char*)name-&gt;bytes(), name-&gt;utf8_length(=
));<br>
+=C2=A0 =C2=A0ss.write((const char*)signature-&gt;bytes(), signature-&gt;ut=
f8_length());<br>
+=C2=A0 =C2=A0ss.print(&quot; is abstract&quot;);<br>
+-=C2=A0 return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NU=
LL);<br>
++=C2=A0 return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);=
<br>
+ }<br>
+ <br>
+ Symbol* MethodFamily::generate_conflicts_message(GrowableArray&lt;Method*=
&gt;* methods, TRAPS) const {<br>
+@@ -521,7 +521,7 @@ Symbol* MethodFamily::generate_conflicts_message(Growa=
bleArray&lt;Method*&gt;* methods<br>
+=C2=A0 =C2=A0 =C2=A0ss.print(&quot;.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0ss.write((const char*)name-&gt;bytes(), name-&gt;utf8_=
length());<br>
+=C2=A0 =C2=A0}<br>
+-=C2=A0 return SymbolTable::new_symbol(ss.base(), (int)ss.size(), CHECK_NU=
LL);<br>
++=C2=A0 return SymbolTable::new_symbol(ss.base(), (int)ss.size(), THREAD);=
<br>
+ }<br>
+ <br>
+ <br>
+diff --git a/hotspot/src/share/vm/classfile/symbolTable.cpp b/hotspot/src/=
share/vm/classfile/symbolTable.cpp<br>
+index ec97077b..2621a7d6 100644<br>
+--- a/hotspot/src/share/vm/classfile/symbolTable.cpp<br>
++++ b/hotspot/src/share/vm/classfile/symbolTable.cpp<br>
+@@ -249,7 +249,7 @@ Symbol* SymbolTable::lookup(const char* name, int len,=
 TRAPS) {<br>
+=C2=A0 =C2=A0MutexLocker ml(SymbolTable_lock, THREAD);<br>
+ <br>
+=C2=A0 =C2=A0// Otherwise, add to symbol to table<br>
+-=C2=A0 return the_table()-&gt;basic_add(index, (u1*)name, len, hashValue,=
 true, CHECK_NULL);<br>
++=C2=A0 return the_table()-&gt;basic_add(index, (u1*)name, len, hashValue,=
 true, THREAD);<br>
+ }<br>
+ <br>
+ Symbol* SymbolTable::lookup(const Symbol* sym, int begin, int end, TRAPS)=
 {<br>
+@@ -288,7 +288,7 @@ Symbol* SymbolTable::lookup(const Symbol* sym, int beg=
in, int end, TRAPS) {<br>
+=C2=A0 =C2=A0// Grab SymbolTable_lock first.<br>
+=C2=A0 =C2=A0MutexLocker ml(SymbolTable_lock, THREAD);<br>
+ <br>
+-=C2=A0 return the_table()-&gt;basic_add(index, (u1*)buffer, len, hashValu=
e, true, CHECK_NULL);<br>
++=C2=A0 return the_table()-&gt;basic_add(index, (u1*)buffer, len, hashValu=
e, true, THREAD);<br>
+ }<br>
+ <br>
+ Symbol* SymbolTable::lookup_only(const char* name, int len,<br>
+diff --git a/hotspot/src/share/vm/classfile/systemDictionary.cpp b/hotspot=
/src/share/vm/classfile/systemDictionary.cpp<br>
+index 3e64b719..b1dd335c 100644<br>
+--- a/hotspot/src/share/vm/classfile/systemDictionary.cpp<br>
++++ b/hotspot/src/share/vm/classfile/systemDictionary.cpp<br>
+@@ -236,15 +236,15 @@ Klass* SystemDictionary::resolve_or_null(Symbol* cla=
ss_name, Handle class_loader<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 class_name-=
&gt;as_C_string(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 class_loade=
r.is_null() ? &quot;null&quot; : class_loader-&gt;klass()-&gt;name()-&gt;as=
_C_string()));<br>
+=C2=A0 =C2=A0if (FieldType::is_array(class_name)) {<br>
+-=C2=A0 =C2=A0 return resolve_array_class_or_null(class_name, class_loader=
, protection_domain, CHECK_NULL);<br>
++=C2=A0 =C2=A0 return resolve_array_class_or_null(class_name, class_loader=
, protection_domain, THREAD);<br>
+=C2=A0 =C2=A0} else if (FieldType::is_obj(class_name)) {<br>
+=C2=A0 =C2=A0 =C2=A0ResourceMark rm(THREAD);<br>
+=C2=A0 =C2=A0 =C2=A0// Ignore wrapping L and ;.<br>
+=C2=A0 =C2=A0 =C2=A0TempNewSymbol name =3D SymbolTable::new_symbol(class_n=
ame-&gt;as_C_string() + 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 class_name-&gt;utf8_le=
ngth() - 2, CHECK_NULL);<br>
+-=C2=A0 =C2=A0 return resolve_instance_class_or_null(name, class_loader, p=
rotection_domain, CHECK_NULL);<br>
++=C2=A0 =C2=A0 return resolve_instance_class_or_null(name, class_loader, p=
rotection_domain, THREAD);<br>
+=C2=A0 =C2=A0} else {<br>
+-=C2=A0 =C2=A0 return resolve_instance_class_or_null(class_name, class_loa=
der, protection_domain, CHECK_NULL);<br>
++=C2=A0 =C2=A0 return resolve_instance_class_or_null(class_name, class_loa=
der, protection_domain, THREAD);<br>
+=C2=A0 =C2=A0}<br>
+ }<br>
+ <br>
+diff --git a/hotspot/src/share/vm/memory/heapInspection.hpp b/hotspot/src/=
share/vm/memory/heapInspection.hpp<br>
+index 09ee6602..c5fec15c 100644<br>
+--- a/hotspot/src/share/vm/memory/heapInspection.hpp<br>
++++ b/hotspot/src/share/vm/memory/heapInspection.hpp<br>
+@@ -367,7 +367,7 @@ class HeapInspection : public StackObj {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0_csv_format(csv_format), _print_help(print_help=
),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0_print_class_stats(print_class_stats), _columns=
(columns) {}<br>
+=C2=A0 =C2=A0void heap_inspection(outputStream* st) NOT_SERVICES_RETURN;<b=
r>
+-=C2=A0 size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filt=
er =3D NULL) NOT_SERVICES_RETURN;<br>
++=C2=A0 size_t populate_table(KlassInfoTable* cit, BoolObjectClosure* filt=
er =3D NULL) NOT_SERVICES_RETURN_(0);<br>
+=C2=A0 =C2=A0static void find_instances_at_safepoint(Klass* k, GrowableArr=
ay&lt;oop&gt;* result) NOT_SERVICES_RETURN;<br>
+=C2=A0 private:<br>
+=C2=A0 =C2=A0void iterate_over_heap(KlassInfoTable* cit, BoolObjectClosure=
* filter =3D NULL);<br>
+diff --git a/hotspot/src/share/vm/memory/metaspaceShared.hpp b/hotspot/src=
/share/vm/memory/metaspaceShared.hpp<br>
+index 2f3abae6..d58ebecb 100644<br>
+--- a/hotspot/src/share/vm/memory/metaspaceShared.hpp<br>
++++ b/hotspot/src/share/vm/memory/metaspaceShared.hpp<br>
+@@ -93,7 +93,7 @@ class MetaspaceShared : AllStatic {<br>
+=C2=A0 =C2=A0static void preload_and_dump(TRAPS) NOT_CDS_RETURN;<br>
+=C2=A0 =C2=A0static int preload_and_dump(const char * class_list_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GrowableArray&lt;Klass*&gt;* class_pr=
omote_order,<br>
+-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRAPS) NOT_CDS_RETURN;<br>
++=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TRAPS) NOT_CDS_RETURN_(0);<br>
+ <br>
+=C2=A0 =C2=A0static ReservedSpace* shared_rs() {<br>
+=C2=A0 =C2=A0 =C2=A0CDS_ONLY(return _shared_rs);<br>
+diff --git a/hotspot/src/share/vm/oops/constantPool.hpp b/hotspot/src/shar=
e/vm/oops/constantPool.hpp<br>
+index 124c970e..dae574c0 100644<br>
+--- a/hotspot/src/share/vm/oops/constantPool.hpp<br>
++++ b/hotspot/src/share/vm/oops/constantPool.hpp<br>
+@@ -353,7 +353,7 @@ class ConstantPool : public Metadata {<br>
+ <br>
+=C2=A0 =C2=A0Klass* klass_at(int which, TRAPS) {<br>
+=C2=A0 =C2=A0 =C2=A0constantPoolHandle h_this(THREAD, this);<br>
+-=C2=A0 =C2=A0 return klass_at_impl(h_this, which, CHECK_NULL);<br>
++=C2=A0 =C2=A0 return klass_at_impl(h_this, which, THREAD);<br>
+=C2=A0 =C2=A0}<br>
+ <br>
+=C2=A0 =C2=A0Symbol* klass_name_at(int which);=C2=A0 // Returns the name, =
w/o resolving.<br>
+diff --git a/hotspot/src/share/vm/prims/jvm.cpp b/hotspot/src/share/vm/pri=
ms/jvm.cpp<br>
+index 6f2221c4..daa69f89 100644<br>
+--- a/hotspot/src/share/vm/prims/jvm.cpp<br>
++++ b/hotspot/src/share/vm/prims/jvm.cpp<br>
+@@ -4368,7 +4368,7 @@ JVM_ENTRY(jlong,JVM_DTraceActivate(<br>
+=C2=A0 =C2=A0 =C2=A0JVM_DTraceProvider* providers))<br>
+=C2=A0 =C2=A0JVMWrapper(&quot;JVM_DTraceActivate&quot;);<br>
+=C2=A0 =C2=A0return DTraceJSDT::activate(<br>
+-=C2=A0 =C2=A0 version, module_name, providers_count, providers, CHECK_0);=
<br>
++=C2=A0 =C2=A0 version, module_name, providers_count, providers, THREAD);<=
br>
+ JVM_END<br>
+ <br>
+ JVM_ENTRY(jboolean,JVM_DTraceIsProbeEnabled(JNIEnv* env, jmethodID method=
))<br>
+diff --git a/hotspot/src/share/vm/runtime/reflection.cpp b/hotspot/src/sha=
re/vm/runtime/reflection.cpp<br>
+index d9fddbe4..a5f73793 100644<br>
+--- a/hotspot/src/share/vm/runtime/reflection.cpp<br>
++++ b/hotspot/src/share/vm/runtime/reflection.cpp<br>
+@@ -1093,7 +1093,7 @@ oop Reflection::invoke(instanceKlassHandle klass, me=
thodHandle reflected_method,<br>
+=C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0if (rtype =3D=3D T_BOOLEAN || rtype =3D=3D T_BYTE || r=
type =3D=3D T_CHAR || rtype =3D=3D T_SHORT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0narrow((jvalue*) result.get_value_addr(), rtype=
, CHECK_NULL);<br>
+-=C2=A0 =C2=A0 return box((jvalue*) result.get_value_addr(), rtype, CHECK_=
NULL);<br>
++=C2=A0 =C2=A0 return box((jvalue*) result.get_value_addr(), rtype, THREAD=
);<br>
+=C2=A0 =C2=A0}<br>
+ }<br>
+ <br>
+diff --git a/hotspot/src/share/vm/runtime/sharedRuntime.cpp b/hotspot/src/=
share/vm/runtime/sharedRuntime.cpp<br>
+index 013aa7a2..df4cde96 100644<br>
+--- a/hotspot/src/share/vm/runtime/sharedRuntime.cpp<br>
++++ b/hotspot/src/share/vm/runtime/sharedRuntime.cpp<br>
+@@ -1045,7 +1045,7 @@ Handle SharedRuntime::find_callee_info(JavaThread* t=
hread, Bytecodes::Code&amp; bc,<br>
+=C2=A0 =C2=A0// last java frame on stack (which includes native call frame=
s)<br>
+=C2=A0 =C2=A0vframeStream vfst(thread, true);=C2=A0 // Do not skip and jav=
aCalls<br>
+ <br>
+-=C2=A0 return find_callee_info_helper(thread, vfst, bc, callinfo, CHECK_(=
Handle()));<br>
++=C2=A0 return find_callee_info_helper(thread, vfst, bc, callinfo, THREAD)=
;<br>
+ }<br>
+ <br>
+ <br>
+diff --git a/hotspot/src/share/vm/services/memTracker.hpp b/hotspot/src/sh=
are/vm/services/memTracker.hpp<br>
+index 8ea859dd..535147f8 100644<br>
+--- a/hotspot/src/share/vm/services/memTracker.hpp<br>
++++ b/hotspot/src/share/vm/services/memTracker.hpp<br>
+@@ -64,7 +64,7 @@ class MemTracker : AllStatic {<br>
+=C2=A0 =C2=A0 =C2=A0const NativeCallStack&amp; stack, MEMFLAGS flag =3D mt=
None) { }<br>
+=C2=A0 =C2=A0static inline void record_virtual_memory_commit(void* addr, s=
ize_t size, const NativeCallStack&amp; stack) { }<br>
+=C2=A0 =C2=A0static inline Tracker get_virtual_memory_uncommit_tracker() {=
 return Tracker(); }<br>
+-=C2=A0 static inline Tracker get_virtual_memory_release_tracker() { }<br>
++=C2=A0 static inline Tracker get_virtual_memory_release_tracker() { retur=
n Tracker(); }<br>
+=C2=A0 =C2=A0static inline void record_virtual_memory_type(void* addr, MEM=
FLAGS flag) { }<br>
+=C2=A0 =C2=A0static inline void record_thread_stack(void* addr, size_t siz=
e) { }<br>
+=C2=A0 =C2=A0static inline void release_thread_stack(void* addr, size_t si=
ze) { }<br>
diff --git a/recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-th=
e-Wreturn-type-warning.patch b/recipes-core/openjdk/patches-openjdk-8/1007-=
hotspot-aarch64-Turn-on-the-Wreturn-type-warning.patch<br>
similarity index 100%<br>
rename from recipes-core/openjdk/patches-openjdk-8/1007-hotspot-Turn-on-the=
-Wreturn-type-warning.patch<br>
rename to recipes-core/openjdk/patches-openjdk-8/1007-hotspot-aarch64-Turn-=
on-the-Wreturn-type-warning.patch<br>
-- <br>
2.39.2<br>
<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#209): <a href=3D"https://lists.yoctoproject.org/g/yocto=
-patches/message/209" rel=3D"noreferrer" target=3D"_blank">https://lists.yo=
ctoproject.org/g/yocto-patches/message/209</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/106327342/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/106327342/924729</a><br>
Group Owner: <a href=3D"mailto:yocto-patches%2Bowner@lists.yoctoproject.org=
" target=3D"_blank">yocto-patches+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leav=
e/13169857/924729/1023951714/xyzzy" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.yoctoproject.org/g/yocto-patches/leave/13169857/924729/10239517=
14/xyzzy</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticot=
imo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
<br>
</blockquote></div></div>

--00000000000043a7100619b52bc9--

