// t3s6origins4pathls10prediction


#include "BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue.h"
#include <sstream>

#define SELF BeJwrMS42yy_1KTM_1MKzYpSCzJyCk2NCgoSk3JTC7JzM8DALDuAue

using namespace SPL;

std::auto_ptr<TupleMappings> SELF::mappings_(SELF::initMappings());

static void addMapping(TupleMappings & tm, TypeOffset & offset,
                       std::string const & name, uint32_t index)
{
    tm.nameToIndex_.insert(std::make_pair(name, index)); 
    tm.indexToName_.push_back(name);
    tm.indexToTypeOffset_.push_back(offset);    
}

static Tuple * initer() { return new SELF(); }

TupleMappings* SELF::initMappings()
{
    instantiators_.insert(std::make_pair("tuple<rstring origin,rstring path,list<rstring> prediction>",&initer));
    TupleMappings * tm = new TupleMappings();
#define MY_OFFSETOF(member, base) \
    ((uintptr_t)&reinterpret_cast<Self*>(base)->member) - (uintptr_t)base
   
    // initialize the mappings 
    
    {
        std::string s("origin");
        TypeOffset t(MY_OFFSETOF(origin_, tm), 
                     Meta::Type::typeOf<SPL::rstring >(), 
                     &typeid(SPL::rstring));
        addMapping(*tm, t, s, 0);
    }
    
    {
        std::string s("path");
        TypeOffset t(MY_OFFSETOF(path_, tm), 
                     Meta::Type::typeOf<SPL::rstring >(), 
                     &typeid(SPL::rstring));
        addMapping(*tm, t, s, 1);
    }
    
    {
        std::string s("prediction");
        TypeOffset t(MY_OFFSETOF(prediction_, tm), 
                     Meta::Type::typeOf<SPL::list<SPL::rstring > >(), 
                     &typeid(SPL::list<SPL::rstring >));
        addMapping(*tm, t, s, 2);
    }
    
    return tm;
}

void SELF::deserialize(std::istream & istr, bool withSuffix)
{
   std::string s;
   char c;

   istr >> c; if (!istr) { return; }
   if (c != '{') { istr.setstate(std::ios_base::failbit); return; }
   
   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "origin") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   if (withSuffix)
     SPL::deserializeWithSuffix(istr, origin_);
   else
     istr >> origin_;
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   if (c != ',') { istr.setstate(std::ios_base::failbit); return; }

   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "path") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   if (withSuffix)
     SPL::deserializeWithSuffix(istr, path_);
   else
     istr >> path_;
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   if (c != ',') { istr.setstate(std::ios_base::failbit); return; }

   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "prediction") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   if (withSuffix)
     SPL::deserializeWithSuffix(istr, prediction_);
   else
     istr >> prediction_;
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   
   if (c != '}') { istr.setstate(std::ios_base::failbit); return; }
}

void SELF::deserializeWithNanAndInfs(std::istream & istr, bool withSuffix)
{
   std::string s;
   char c;

   istr >> c; if (!istr) { return; }
   if (c != '{') { istr.setstate(std::ios_base::failbit); return; }
   
   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "origin") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   SPL::deserializeWithNanAndInfs(istr, origin_, withSuffix);
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   if (c != ',') { istr.setstate(std::ios_base::failbit); return; }

   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "path") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   SPL::deserializeWithNanAndInfs(istr, path_, withSuffix);
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   if (c != ',') { istr.setstate(std::ios_base::failbit); return; }

   if (!readAttributeIdentifier(istr, s)) { return; }
   if (s != "prediction") { istr.setstate(std::ios_base::failbit); return; }
   istr >> c; if (!istr) { return; }
   if (c != '=') { istr.setstate(std::ios_base::failbit); return; }
   SPL::deserializeWithNanAndInfs(istr, prediction_, withSuffix);
   if (!istr) { return; }  
   istr >> c; if (!istr) { return; }
   
   if (c != '}') { istr.setstate(std::ios_base::failbit); return; }
}

void SELF::serialize(std::ostream & ostr) const
{
    ostr << '{'
         << "origin=" << get_origin()  << ","
         << "path=" << get_path()  << ","
         << "prediction=" << get_prediction()  
         << '}';
}

void SELF::serializeWithPrecision(std::ostream & ostr) const
{
    ostr << '{';
    SPL::serializeWithPrecision(ostr << "origin=", get_origin()) << ",";
    SPL::serializeWithPrecision(ostr << "path=", get_path()) << ",";
    SPL::serializeWithPrecision(ostr << "prediction=", get_prediction()) ;
    ostr << '}';
}

SELF& SELF::clear()
{
    get_origin().clear();
    get_path().clear();
    get_prediction().clear();

    return *this;
}

void SELF::normalizeBoundedSetsAndMaps()
{
    SPL::normalizeBoundedSetsAndMaps(*this);
}


