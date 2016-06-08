#include maps\mp\_utility;
#include common_scripts\utility;

//Intricate - Functions from WaW will help improve the mod.
array_exclude( array, arrayExclude )// returns "array" minus all members of arrayExclude
{
	newarray = array;
	for( i = 0;i < arrayExclude.size;i ++ )
	{
		if( is_in_array( array, arrayExclude[ i ] ) )
			newarray = array_remove( newarray, arrayExclude[ i ] );
	}
	
	return newarray;
}

is_in_array( aeCollection, eFindee )
{
	for( i = 0; i < aeCollection.size; i ++ )
	{
		if( aeCollection[ i ] == eFindee )
			return( true ); 
	}
	
	return( false ); 
}

is_facing( facee, degree )
{
	orientation = self getPlayerAngles();
	forwardVec = anglesToForward( orientation );
	forwardVec2D = ( forwardVec[0], forwardVec[1], 0 );
	unitForwardVec2D = VectorNormalize( forwardVec2D );
	toFaceeVec = facee.origin - self.origin;
	toFaceeVec2D = ( toFaceeVec[0], toFaceeVec[1], 0 );
	unitToFaceeVec2D = VectorNormalize( toFaceeVec2D );
	
	dotProduct = VectorDot( unitForwardVec2D, unitToFaceeVec2D );
	return ( dotProduct > degree );
}
