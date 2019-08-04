#ifndef TOOLKIT_COMMON_VERSION_HPP
#define TOOLKIT_COMMON_VERSION_HPP

#include "Object.hpp"

namespace octetos
{
namespace toolkit
{

       
	/**
	 * \brief Informacion de Version
	 * 
	 **/
	class Version: public Object
	{
	public:		
		enum Stage
		{
                        unknown,
                        snapshot,       
			alpha,
			beta,
                        rc,
			release
		};
		
	private:	
		short major;
		short minor;
		short patch;
                short tweak;
                unsigned long build;
		Stage stage;
                std::string name;
                
	public:
		short getMajor() const;
		short getMinor() const;
		short getPatch() const;
		unsigned long getBuild() const;
		Stage getStage() const;
                const std::string& getName() const;
                bool operator >=(const Version& v);
                bool getFixedExternalParser();//hay un fallo durante el parseo que se genera en modulos exterior
                
		Version();
                Version(short major,short minor);
                void set(short major,short minor,short patch,Stage stage,unsigned long build, const std::string& name);
                void setNumbers(short major,short minor,short patch);
                void setNumbers(short major,short minor);
                void setNumbers(short major);
                void setStage(Stage stage);
                void setBuild(unsigned long build);
                void setName(const std::string& name);
		std::string toString() const;                
                bool fromFile(const std::string& f);                        
                bool fromString(const std::string& str);        
	};
        
}
}
#endif
